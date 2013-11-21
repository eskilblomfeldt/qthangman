#include <QtGui/QGuiApplication>
#include <QtQml>
#include "qtquick2applicationviewer.h"
#include "data.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    QQmlContext *ctx = viewer.engine()->rootContext();
    ctx->setContextProperty(QStringLiteral("applicationData"), new Data(&app));

    viewer.setMainQmlFile(QStringLiteral("qml/hangman/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
