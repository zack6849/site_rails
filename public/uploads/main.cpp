#include <iostream>
#include <cstdlib>

using namespace std;

void Adding() {
    int Fnum, Snum, Answer;
    cout << "Enter your first number here: " << endl;
    cin >> Fnum;
    cout << "Enter your second number here: " << endl;
    cin >> Snum;
    Answer = Fnum + Snum;
    cout << Answer << endl;
}

void Subtracting() {
    int Fnum, Snum, Answer;
    cout << "Enter your first number here: " << endl;
    cin >> Fnum;
    cout << "Enter your second number here: " << endl;
    cin >> Snum;
    Answer = Fnum - Snum;
    cout << Answer << endl;
}



void Multiplying() {
    int Fnum, Snum, Answer;
    cout << "Enter your first number here: " << endl;
    cin >> Fnum;
    cout << "Enter your second number here: " << endl;
    cin >> Snum;
    Answer = Fnum * Snum;
    cout << Answer << endl;
}



void Dividing() {
    int Fnum, Snum, Answer;
    cout << "Enter your first number here: " << endl;
    cin >> Fnum;
    cout << "Enter your second number here: " << endl;
    cin >> Snum;
    Answer = Fnum / Snum;
    cout << Answer << endl;
}

int Questions() {
    int Ans;
    cout << "What type of calculation do you want to use?" << endl;
    cout << "1) Adding. 2) Subtraction. 3) Multiplying. 4) Dividing. 5) Exit" << endl;
    cin >> Ans;
    switch(Ans){
        case 1: 
            Adding();
            Questions();
            break;
       case 2: 
            Subtracting();
            Questions();
            break;
       case 3: 
            Multiplying();
            Questions();
            break;
       case 4: 
            Dividing();
            Questions();
            break;
       case 5:
            exit(0);
            break;
       default:
            cout << "Invalid Choice!" << endl;
            Questions();
    }
}

int main(void) {
    Questions();
    return 0;
}
