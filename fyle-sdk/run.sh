source ../setup.sh

if [[ $OSTYPE == darwin* ]]
then
  SED_EXTRA_ARGS='""';
fi

sed -i $SED_EXTRA_ARGS "s?{{CLIENT_ID}}?${CLIENT_ID}?g" "settings.yaml";
sed -i $SED_EXTRA_ARGS "s?{{CLIENT_SECRET}}?${CLIENT_SECRET}?g" "settings.yaml";
sed -i $SED_EXTRA_ARGS "s?{{TOKEN_URL}}?${TOKEN_URL}?g" "settings.yaml";
sed -i $SED_EXTRA_ARGS "s?{{BASE_URI}}?${BASE_URI}?g" "settings.yaml";
sed -i $SED_EXTRA_ARGS "s?{{REFRESH_TOKEN}?${REFRESH_TOKEN}?g" "settings.yaml";
