#include <iostream>
#include <vector>
#include <string>
#include <random>


int randomNumber()
{
    std::random_device random;
    std::uniform_int_distribution<int> dist (0,83);
    return dist(random);
}

int main(){
   const char characters [84] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
'.', '!', ',', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '+', '=', '/', '\\', '|', '[', ']', '{', '}', '<', '>', '?', ';', ':', '`', '~'
};

 

    std::string a = "";
    int k;
    std::cin >> k; 
    int i = 0;

    if (!std::cin) {
        // input was not an integer
        k = 15;
    }



    for ( int j = 0; j < k; ++j  ){
        a = a + characters[randomNumber()];
    }

//while (i<k)
//    { 
//        a = a + characters[randomNumber()];
//        ++i;
//    }
    std::cout << a << "\n";
    return 0;
}
