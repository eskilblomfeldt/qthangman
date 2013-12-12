#include "data.h"
#include <QFile>
#include <QDebug>
#include <time.h>
#include <QBuffer>
#include <QtConcurrent/QtConcurrentRun>

Data *Data::m_instance = 0;

Data::Data(QObject *parent)
    : QObject(parent)
    , m_lock(QMutex::Recursive)
{
    m_instance = this;
    qsrand(::time(0));
    connect(this, SIGNAL(vowelBought(QChar)), this, SLOT(registerLetterBought(QChar)));

    QtConcurrent::run(this, &Data::initWordList);
}

void Data::initWordList()
{
    QMutexLocker locker(&m_lock);
    qsrand(::time(0) + 1000);
    QFile file(":/enable2.txt");
    if (file.open(QIODevice::ReadOnly)) {
        QByteArray allData = file.readAll();
        QBuffer buffer(&allData);
        if (!buffer.open(QIODevice::ReadOnly))
            qFatal("Couldn't open buffer for reading!");

        while (!buffer.atEnd()) {
            QByteArray ba = buffer.readLine().trimmed().toUpper();
            if (!ba.isEmpty() && ba.length() < 10)
                m_wordList.append(QString::fromLatin1(ba));
        }
    }

    chooseRandomWord();
}

void Data::reset()
{
    m_lettersOwned.clear();
    emit lettersOwnedChanged();
    emit errorCountChanged();
    chooseRandomWord();
}

void Data::chooseRandomWord()
{
    QMutexLocker locker(&m_lock);
    if (m_wordList.isEmpty())
        return;

    m_word = m_wordList.at(qrand() % m_wordList.size());
    emit wordChanged();
}

QString Data::vowels() const
{
    return QStringLiteral("AEIOU");
}

QString Data::consonants() const
{
    return QStringLiteral("BCDFGHJKLMNPQRSTVWXYZ");
}

int Data::errorCount() const
{
    int count = 0;
    foreach (QChar c, m_lettersOwned) {
        if (!m_word.contains(c))
            ++count;
    }
    return count;
}

void Data::reveal()
{
    m_lettersOwned += vowels() + consonants();
    emit lettersOwnedChanged();
    emit errorCountChanged();
}

void Data::gameOverReveal()
{
    m_lettersOwned += vowels() + consonants();
    emit lettersOwnedChanged();
}

void Data::guessWord(const QString &word)
{
    if (word.compare(m_word, Qt::CaseInsensitive) == 0) {
        m_lettersOwned += m_word.toUpper();
    } else {
        // Small hack to get an additional penalty for guessing wrong
        static int i=0;
        Q_ASSERT(i < 10);
        m_lettersOwned += QString::number(i++);
        emit errorCountChanged();
    }
    emit lettersOwnedChanged();
}

void Data::requestLetter(const QString &letterString)
{
    Q_ASSERT(letterString.size() == 1);
    QChar letter = letterString.at(0);
    if (vowels().contains(letter))
        buyVowel(letter);
    else
        registerLetterBought(letter);
}

void Data::registerLetterBought(const QChar &letter)
{
    if (m_lettersOwned.contains(letter))
        return;

    m_lettersOwned.append(letter);
    emit lettersOwnedChanged();

    if (!m_word.contains(letter))
        emit errorCountChanged();
}
