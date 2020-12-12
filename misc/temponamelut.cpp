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
    } else if(isInRange(25, 40, tempo)) {
        idx = 1;
    } else if(isInRange(40, 46, tempo)) {
        idx = 2;
    } else if(isInRange(46, 56, tempo)) {
        idx = 3;
    } else if(isInRange(56, 62, tempo)) {
        idx = 4;
    } else if(isInRange(62, 72, tempo)) {
        idx = 5;
    } else if(isInRange(72, 80, tempo)) {
        idx = 6;
    } else if(isInRange(80, 88, tempo)) {
        idx = 7;
    } else if(isInRange(88, 96, tempo)) {
        idx = 8;
    } else if(isInRange(96, 108, tempo)) {
        idx = 9;
    } else if(isInRange(108, 120, tempo)) {
        idx = 10;
    } else if(isInRange(120, 132, tempo)) {
        idx = 11;
    } else if(isInRange(132, 144, tempo)) {
        idx = 12;
    } else if(isInRange(144, 162, tempo)) {
        idx = 13;
    } else if(isInRange(162, 184, tempo)) {
        idx = 14;
    } else if(isInRange(184, 208, tempo)) {
        idx = 15;
    } else {
        idx = 16;
    }

    return tempoNameLUT::LUT.at(idx).toLocal8Bit().constData();
}
