#!/bin/bash

for country in kenya myanmar vietnam; do
  echo "Getting loans from ${country}..."
  echo "<table>" > content/posts/${country}/investments.html
  echo "<tr><th><th>Name<th>Loan Category<th>What will this loan do?" >> content/posts/${country}/investments.html

  curl -s "https://api.kivaws.org/graphql?query=$(cat regiondata/${country}.data)" | \
  jq -r '.data.lend.loans.values[] | "<tr><td><a href=\"https://www.kiva.org/lend/" + (.id|tostring) + "\"><img src=\"" + .image.url + "\"></a><td><a href=\"https://www.kiva.org/lend/" + (.id|tostring) + "\">" + .name + "</a><td><a href=\"https://www.kiva.org/lend/" + (.id|tostring) + "\">" + .activity.name + "</a><td><a href=\"https://www.kiva.org/lend/" + (.id|tostring) + "\">" + .whySpecial + "</a></tr>"' \
  >> content/posts/${country}/investments.html

  echo "</table><br /><strong>Powered by <a href="https://www.kiva.org">Kiva</a></strong>" >> content/posts/${country}/investments.html
done
