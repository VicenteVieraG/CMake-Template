#include <iostream>
#include <config.hpp>

int main(int argc, char* argv[]){
    std::cout<<project_name<<std::endl;
    std::cout<<project_version<<std::endl;
    std::cout<<"C++ Standard: "<<__cplusplus<<std::endl;

    return 0;
}