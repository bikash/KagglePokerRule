// simple C++-script to manipulate data
// before running the script replace all commas in the original csv-files except header

// sorting cards and creating new features as the absolute value of difference between neighbor cards

#include <fstream>
#include <string>
#include <algorithm>
#include <functional>

using namespace std;

int main(int argc, char* argv[])
{
  ifstream train("train.csv");
  ofstream modifiedTrain("train_modified.csv");
  string s;
  train >> s;//header
  modifiedTrain << "S1count,S2count,S3count,S4count,C12diff,C23diff,C34diff,C45diff,C51diff,hand" << endl;
  
  int S1, C1, S2, C2, S3, C3, S4, C4, S5, C5, hand;
  int S1count, S2count, S3count, S4count;
  int C12diff, C23diff, C34diff, C45diff, C51diff;
  int CC[5];
  for(int i = 0; i < 25010; ++i)
  {
    train >> S1 >> C1 >> S2 >> C2 >> S3 >> C3 >> S4 >> C4 >> S5 >> C5 >> hand;
    S1count = S2count = S3count = S4count = 0;
    if(S1 == 1) ++S1count; if(S2 == 1) ++S1count; if(S3 == 1) ++S1count; if(S4 == 1) ++S1count; if(S5 == 1) ++S1count;
    if(S1 == 2) ++S2count; if(S2 == 2) ++S2count; if(S3 == 2) ++S2count; if(S4 == 2) ++S2count; if(S5 == 2) ++S2count;
    if(S1 == 3) ++S3count; if(S2 == 3) ++S3count; if(S3 == 3) ++S3count; if(S4 == 3) ++S3count; if(S5 == 3) ++S3count;
    if(S1 == 4) ++S4count; if(S2 == 4) ++S4count; if(S3 == 4) ++S4count; if(S4 == 4) ++S4count; if(S5 == 4) ++S4count;
    CC[0] = C1; CC[1] = C2; CC[2] = C3; CC[3] = C4; CC[4] = C5;
    sort(CC, CC+5);
    C1 = CC[0]; C2 = CC[1]; C3 = CC[2]; C4 = CC[3]; C5 = CC[4];
    
    C12diff = abs(C2-C1); C23diff = abs(C3-C2); C34diff = abs(C4-C3); C45diff = abs(C5-C4); C51diff = abs(C1-C5);
    
    //printf ("S1count: %d  \n", S1count);

    modifiedTrain << S1count << "," << S2count << "," << S3count << "," << S4count << "," << 
      C12diff << "," << C23diff << "," << C34diff << "," << C45diff << "," << C51diff << "," << hand << endl;
  }
  
  ifstream test("test.csv");
  ofstream modifiedTest("test_modified.csv");
  test >> s;//header
  modifiedTest << "S1count,S2count,S3count,S4count,C12diff,C23diff,C34diff,C45diff,C51diff,id" << endl;
  int id;
  for(int i = 0; i < 1000000; ++i)
  {
    test >> id >> S1 >> C1 >> S2 >> C2 >> S3 >> C3 >> S4 >> C4 >> S5 >> C5;
    S1count = S2count = S3count = S4count = 0;
    if(S1 == 1) ++S1count; if(S2 == 1) ++S1count; if(S3 == 1) ++S1count; if(S4 == 1) ++S1count; if(S5 == 1) ++S1count;
    if(S1 == 2) ++S2count; if(S2 == 2) ++S2count; if(S3 == 2) ++S2count; if(S4 == 2) ++S2count; if(S5 == 2) ++S2count;
    if(S1 == 3) ++S3count; if(S2 == 3) ++S3count; if(S3 == 3) ++S3count; if(S4 == 3) ++S3count; if(S5 == 3) ++S3count;
    if(S1 == 4) ++S4count; if(S2 == 4) ++S4count; if(S3 == 4) ++S4count; if(S4 == 4) ++S4count; if(S5 == 4) ++S4count;
    CC[0] = C1; CC[1] = C2; CC[2] = C3; CC[3] = C4; CC[4] = C5;
    sort(CC, CC+5);
    C1 = CC[0]; C2 = CC[1]; C3 = CC[2]; C4 = CC[3]; C5 = CC[4];
    
    C12diff = abs(C2-C1); C23diff = abs(C3-C2); C34diff = abs(C4-C3); C45diff = abs(C5-C4); C51diff = abs(C1-C5);
    
    modifiedTest << S1count << "," << S2count << "," << S3count << "," << S4count << "," << 
      C12diff << "," << C23diff << "," << C34diff << "," << C45diff << "," << C51diff << "," << id << endl;
  }
  
  modifiedTest.close();
  modifiedTrain.close();
  test.close();
  train.close();
  return 0;
}
