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
        "Adagissimo", // 0 < 24
        "Grave", // 25 < 40
        "Largo", // 40 < 46
        "Lento", // 46 < 56
        "Larghetto", // 56 < 62
        "Adagio", // 62 < 72
        "Andante", // 72 < 80
        "Andantino", // 80 < 88
        "Maestoso", // 88 < 96
        "Moderato", // 96 < 108
        "Allegretto", // 108 < 120
        "Animato", // 120 < 132
        "Allegro", // 132 < 144
        "Allegro molto", // 144 < 162
        "Vivace", // 162 < 184
        "Presto", // 184 < 208
        "Prestissimo" // > 208
    };
};

#endif // TEMPONAMELUT_H
