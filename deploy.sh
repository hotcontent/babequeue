git fetch

for branches in $(git for-each-ref --format='%(refname)' refs/remotes/)
do
  branch=${branches/refs\/remotes\/origin\//}

  export BRANCH_NAME=$branch
  docker-compose up -d --build
done
