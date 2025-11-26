#!/bin/bash
SUBSCRIPTION_ID="aa447920-54d6-4652-a2ff-fc5ca25b1dd0"

# Get owner principal IDs
OWNERS=($(az role assignment list --subscription $SUBSCRIPTION_ID --role Owner --query "[].principalId" -o tsv))
COUNT=${#OWNERS[@]}

if [ $COUNT -le 3 ]; then
  echo "Owner count ($COUNT) is within limit"
  exit 0
fi

# Remove excess owners
to_remove=("${OWNERS[@]:3}")
for principal in "${to_remove[@]}"; do
  echo "Removing owner role for $principal"
  az role assignment delete --assignee $principal --role Owner --subscription $SUBSCRIPTION_ID
done
