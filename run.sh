docker run --rm --volume="$PWD:/srv/jekyll" -e "JEKYLL_ENV=production" -p 4000:4000 -it jekyll/jekyll:latest jekyll serve --verbose --trace

# docker run --rm --volume="$PWD:/srv/jekyll" -e "JEKYLL_ENV=production" -p 4000:4000 -it jekyll/jekyll:latest bash