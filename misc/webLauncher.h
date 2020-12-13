#ifndef WEBLAUNCHER_H
#define WEBLAUNCHER_H

#include <QObject>
#include <QUrl>
#include <QDesktopServices>

/* class to help launch web page in an external launcher */
class webLauncher : public QObject {
    Q_OBJECT
public:
    explicit webLauncher(QObject *parent = 0) : QObject(parent) {}
    Q_INVOKABLE void launch(void) {
        QDesktopServices::openUrl(QUrl::fromLocalFile("http://20.67.100.205:8000/"));
    }
};

#endif // WEBLAUNCHER_H
