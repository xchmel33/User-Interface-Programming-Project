#ifndef TEMPONAMELUT_H
#define TEMPONAMELUT_H

#include <QObject>

class tempoNameLUT : public QObject
{
    Q_OBJECT
public:
    explicit tempoNameLUT(QObject *parent = 0);

    Q_INVOKABLE QString getName(int tempo);
private:
    bool isInRange(int low, int high, int val);
    QStringList LUT = {
        "Adagissimo",
        "Grave",
        "Lento",
        "Larghetto",
        "Adagio",
        "Andante",
        "Moderato",
        "Allegro",
        "Vivace",
        "Presto",
        "Prestissimo"
    };
};

#endif // TEMPONAMELUT_H
