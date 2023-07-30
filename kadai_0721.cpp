#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <sstream>

using namespace std;

std::vector<std::string> upperArray;
std::vector<std::string> lowerArray;


// https://hyakunin-issyu.com/hiragana

int createDatabase(){
    ifstream file("haiku.csv");

    if (!file.is_open()) {
        std::cerr << "ファイルを開けませんでした。" << std::endl;
        return 1;
    }

    std::string line;

    while (std::getline(file, line)) {
        std::stringstream ss(line);
        std::string leftPart, rightPart;

        std::getline(ss, leftPart, ','); 
        std::getline(ss, rightPart, ','); 

        upperArray.push_back(leftPart);
        lowerArray.push_back(rightPart);
    }

    return 0;
}

int main(){

    createDatabase();

    string temp;

    size_t size = upperArray.size();

    while (true){
        cout << "上の句(の一部)を入力してください, \n 終了したい場合は END と入力してください" << endl;

        cin >> temp;

        if (temp == "END"){
            break;
        }

        int i = 0;

        for (const auto& element : upperArray) {
            if (element.compare(0, temp.length(), temp) == 0) {
                // std::cout << element << std::endl;
                std::cout << lowerArray[i] << std::endl;
            }
            i++;
        }

        cout << endl;
    }

    return 0;
}