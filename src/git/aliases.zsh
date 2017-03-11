# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which appsapp)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

gi() {
  curl -s "https://www.gitignore.io/api/$*";
}
