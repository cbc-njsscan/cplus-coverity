#import <Foundation/Foundation.h>

// Missing close file read using Objective-C with C like characteristics
int main(int argc, const char * argv[]) {

    @autoreleasepool {

        FILE *fp;

        fp = fopen("./testfile.txt", "r"); // VULNERABILITY HERE: CMissingClose

        char text[100];
        while(fgets(text, 100, fp)) {
            printf("%s", text);
        };

    }

    return 0;

}