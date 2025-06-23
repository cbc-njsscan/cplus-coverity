#import <Foundation/Foundation.h>

// Missing close file read using Objective-C with C like characteristics
int main(int argc, const char * argv[]) {

    @autoreleasepool {

        FILE *fp;

        fp = fopen("./testfile.txt", "r"); // NO VULNERABILITY HERE: CMissingClose
        if(!fp) {
            return 1;
        }

        char text[100];
        while(fgets(text, 100, fp)) {
            printf("%s", text);
        };

        fclose(fp);

    }

    return 0;

}