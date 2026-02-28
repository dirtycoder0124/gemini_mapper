# Drop in subdomains → Get Gemini-exposed API keys.
Just provide a list of domains/subdomains and the script will automatically crawl HTML and JavaScript files to locate exposed Google API keys and test whether they have Gemini access.


# Short Description

Give it a list of domains or subdomains — the script will:

Crawl HTML pages

Discover linked JavaScript files

Extract exposed Google API keys

Test if they have Gemini API access

and report any potentially exploitable keys along with their source location.

# Run the Script
chmod +x gemini_mapper.sh

./gemini_mapper.sh subdomains.txt
