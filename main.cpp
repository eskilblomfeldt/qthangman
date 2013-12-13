#include <QtGui/QGuiApplication>
#include <QtQml>
#include <QtGui/QFont>
#include "qtquick2applicationviewer.h"
#include "data.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QFont globalFont(".Helvetica Neue Interface -M3");
    globalFont.setFamily("Helvetica Neue");
    //globalFont.setWeight(25);

    app.setFont(globalFont);

    QtQuick2ApplicationViewer viewer;

    QQmlContext *ctx = viewer.engine()->rootContext();
    ctx->setContextProperty(QStringLiteral("applicationData"), new Data(&app));

    viewer.setMainQmlFile(QStringLiteral("qml/hangman/main.qml"));

#if defined (Q_OS_IOS)
    viewer.showFullScreen();
#else
    viewer.showExpanded();
#endif
    return app.exec();
}
