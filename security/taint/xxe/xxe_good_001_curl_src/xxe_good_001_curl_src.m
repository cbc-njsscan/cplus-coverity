#import <Foundation/Foundation.h>

#include <curl/curl.h>
#include <stdlib.h> /* for realloc */
#include <string.h> /* for memcpy */

struct memory {
  char *response;
  size_t size;
};

static size_t cb(char *data, size_t size, size_t nmemb, void *clientp)
{
  size_t realsize = size * nmemb;
  struct memory *mem = (struct memory *)clientp;
 
  char *ptr = realloc(mem->response, mem->size + realsize + 1);
  if(!ptr)
    return 0;  /* out of memory */
 
  mem->response = ptr;
  memcpy(&(mem->response[mem->size]), data, realsize);
  mem->size += realsize;
  mem->response[mem->size] = 0;
 
  return realsize;
}
 

int main(void) {
    @autoreleasepool {
    CURL *curl;
    CURLcode res;
    
    struct memory chunk = {0};

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if (!curl) return 1;

    curl_easy_setopt(curl, CURLOPT_URL, "https://example.com/");

    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, cb);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, /* (void *) */&chunk);
    res = curl_easy_perform(curl);


    NSString *tainted = [NSString stringWithUTF8String:chunk.response]; 

    NSURL *xmlURL = [NSURL URLWithString:tainted];

    // NO VULNERABILITY HERE: XXE
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];

    [parser setShouldResolveExternalEntities:NO];
    [parser parse];

    free(chunk.response);

    return 0;
    }
}
