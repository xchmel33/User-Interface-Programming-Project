#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "misc/temponamelut.h"
#include "misc/webLauncher.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("Studenti VUT FIT");
    app.setOrganizationDomain("xchmelo33.org");
    app.setApplicationName("FIT Metronom");

    qmlRegisterType<tempoNameLUT>("TempoLUT", 1, 0, "TempoLUT");
    qmlRegisterType<webLauncher>("WebLauncher", 1, 0, "DonationPage");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
