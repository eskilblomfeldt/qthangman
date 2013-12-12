#include "data.h"

void Data::buyVowel(const QChar &vowel)
{
    emit vowelBought(vowel);
    emit purchaseWasSuccessful(true);
}

bool Data::canMakePurchases()
{
    return true;
}

void Data::initStore()
{

}

QString Data::localizedPriceForLetter(const QString &letter)
{
    Q_UNUSED(letter);
    return QString::fromLatin1("free");
}
