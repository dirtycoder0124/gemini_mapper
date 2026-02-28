# Drop in subdomains → Get Gemini-exposed API keys.
Just provide a list of domains/subdomains and the script will automatically crawl HTML and JavaScript files to locate exposed Google API keys and test whether they have Gemini access.


# Short Description

Give it a list of domains or subdomains — the script will:

1. Crawl HTML pages

2. Discover linked JavaScript files

3. Extract exposed Google API keys

4. Test if they have Gemini API access

and report any potentially exploitable keys along with their source location.

# Run the Script
chmod +x gemini_mapper.sh

./gemini_mapper.sh subdomains.txt

# Output
If Gemini-enabled keys are found, results will be saved in:

gemini_exposed.txt
