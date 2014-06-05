//
//  main.cpp
//  Prob49_PrimePermutation
//
//  Created by Ben Peloquin on 6/3/14.
//  Copyright (c) 2014 B. Peloquin. All rights reserved.
//


//Functions to build
//1) isPrime() or isComposite()
//2) isPermutation() && diff digits
//3) isRelated() [Arithmetic]

bool diffDigits(int n);
bool isComposite(int n);
int*& permutations(int n);
bool related(const int*& arr_ptr);

#include <iostream>
#include <cstdlib>
using namespace std;

int main()
{

    cout << diffDigits(3346) << endl;
    cout << isComposite(7) << endl;
    
    const int* ptr = permutations(1487);
    
    for (int i = 0; i < 6; ++i) {
        cout << ptr[i] << ' ';
    }
    
    cout << endl << related(ptr);
    
    return 0;
}

bool diffDigits(int n) {
    int m = n;
    int dig[4];
    
    //Read digits into an array
    for (int i = 0; i < 4; ++i) {
        dig[i] = m % 10;
        m /= 10;
    }
    
    //Compare contents of array
    for (int i = 0; i < 3; ++i) {
        for (int j = i + 1; j< 4; ++j)
            if (dig[i] == dig[j])
                return 1;
    }
    
    //True if we cycle through array
    return 0;
}

bool isComposite(int n) {
    int m = n / 2;
    
    for (int i = 2; i < m; ++i) {
        if (m % i == 0)
            return 0;
    }
    
    return 1;
}

int*& permutations(int n) {
    int m = n;
    int i_dig[4];
    int* digs = new int[6];
    
    //Read digits into an array
    for (int i = 0; i < 4; ++i) {
        i_dig[i] = m % 10;
        m /= 10;
    }
    
    digs[0] = i_dig[3] * 1000 + i_dig[2] * 100 + i_dig[1] * 10 + i_dig[0];
    digs[1] = i_dig[2] * 1000 + i_dig[3] * 100 + i_dig[1] * 10 + i_dig[0];
    digs[2] = i_dig[3] * 1000 + i_dig[1] * 100 + i_dig[2] * 10 + i_dig[0];
    digs[3] = i_dig[1] * 1000 + i_dig[3] * 100 + i_dig[2] * 10 + i_dig[0];
    digs[4] = i_dig[2] * 1000 + i_dig[1] * 100 + i_dig[3] * 10 + i_dig[0];
    digs[5] = i_dig[1] * 1000 + i_dig[2] * 100 + i_dig[3] * 10 + i_dig[0];
    
    //Sort array
    for (int i = 0; i < 5; ++i) {
        for (int j = i + 1; j < 6; ++j) {
            
            if (digs[i] > digs[j]) {
                int temp = digs[i];
                digs[i] = digs[j];
                digs[j] = temp;
            }
        }
    }
    
    
    return digs;
    
}

//More here
bool related(const int*& arr_ptr) {
    
    //To hold all differences
    int count[15] = {0};
    int n = 0;
    for (int i = 0; i < 5; ++i) {
        for (int j = i + 1; j < 6; ++j) {
            cout << endl << n << ": " << arr_ptr[j] << ", " << arr_ptr[i];
            count[n] = arr_ptr[j] - arr_ptr[i];
            n++;
        }
    }
 
    int dups = 0;
    for (int i = 0; i < 14; ++i) {
        for (int j = i + 1; j < 15; ++j) {
            if (count[i] == count[j]) {
                ++dups;
                cout << i << ' ' << j << endl;
            }
            
        }
    }
    
    return (dups == 4);
    
}