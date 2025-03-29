#ifndef JAZZCUSTOMIZED_H
#define JAZZCUSTOMIZED_H


/**
 * This function creates a file if it does not exist
 * This should usually be used for customized files
 *
 * @param relpath a file path relative to $HOME
 * @param contents of that file
 */
void customized(char *relpath, char *contents);

#endif /* JAZZCUSTOMIZED_H */
