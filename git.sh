mess=$1
push=$2

echo "$mess $push"

git add lib pubspec.yaml assets git.sh
git commit -m "$mess"
if [ $push == 1 ]
then git push
fi