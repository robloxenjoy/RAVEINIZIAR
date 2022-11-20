#define PUNCTUATION_FILTER_CHECK(T) (config.punctuation_filter_regex && !findtext(T, config.punctuation_filter_regex, length(message)) && !findtext(T, config.punctuation_filter_bypass_regex, 1, 2))
