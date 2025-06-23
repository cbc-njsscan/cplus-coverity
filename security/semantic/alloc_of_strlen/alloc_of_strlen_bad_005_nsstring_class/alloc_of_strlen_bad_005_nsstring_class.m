#include <Foundation/Foundation.h>
// No of-type edge because string is initalized via inline message passing
// Utilises NSString length class function which does not include the null
// terminator - a problem if the data is used as a C string.
// Tests NSString class method call leading to type
int main(int argc, const char *argv[]) {
  @autoreleasepool {
    unichar chars[] = {'H', 'e', 'l', 'l', 'o'};
    // Create an NSString from the unichar array
    NSString *string = [NSString stringWithCharacters:chars length:5];

    NSMutableData *data2 =
        // VULNERABILITY HERE: AllocOfStrlen
        [[NSMutableData alloc] initWithLength:[string length]];
  }
}
