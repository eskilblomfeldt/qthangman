#include "data.h"

void Data::buyVowel(const QChar &vowel)
{
    emit vowelBought(vowel);
}
