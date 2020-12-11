#include "temponamelut.h"

tempoNameLUT::tempoNameLUT(QObject *parent):
    QObject( parent )
{
}

bool tempoNameLUT::isInRange(int low, int high, int val) {
    return  ((val-low) <= (high-low));
}

QString tempoNameLUT::getName(int tempo) {
    int idx;

    if(tempo <= 24) {
        idx = 0;
    } else if(isInRange(25, 45, tempo)) {
        idx = 1;
    } else if(isInRange(45, 60, tempo)) {
        idx = 2;
    } else if(isInRange(60, 66, tempo)) {
        idx = 3;
    } else if(isInRange(66, 76, tempo)) {
        idx = 4;
    } else if(isInRange(76, 108, tempo)) {
        idx = 5;
    } else if(isInRange(108, 120, tempo)) {
        idx = 6;
    } else if(isInRange(120, 156, tempo)) {
        idx = 7;
    } else if(isInRange(156, 176, tempo)) {
        idx = 8;
    } else if(isInRange(176, 200, tempo)) {
        idx = 9;
    } else {
        idx = 10;
    }

    return tempoNameLUT::LUT.at(idx).toLocal8Bit().constData();
}
