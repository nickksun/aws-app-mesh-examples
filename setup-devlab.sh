#!/bin/bash

echo "# 0. Clone the repository"
git clone https://github.com/nickksun/aws-app-mesh-examples.git
cd aws-app-mesh-examples
echo "# 1. GETTING STARTED"
cd examples/apps/colorapp
sed "s/1234567/$(aws sts get-caller-identity --output text --query 'Account')/g" colorapp.env.template > colorapp.env
source colorapp.env
echo "# ## Return to examples path"
cd ../../../
echo "# 2. Infrastructure"
echo "# ## Setup VPC"
./infrastructure/vpc.sh
echo "# ## Setup Mesh"
./infrastructure/appmesh-mesh.sh
echo "# ## Setup ECS Cluster"
./infrastructure/ecs-cluster.sh
echo "# 3. ECR"
echo "# ## Setup repositories"
cd apps/colorapp/src
./ecr-init.sh
echo "# ## Push images"
./ecr-deploy.sh
echo "# ## Return to example path"
cd ../../../
4. ECS setup
echo "# ## Deploy ECS Task definitions/services"
cd apps/colorapp/ecs
./ecs-colorapp.sh
echo "# ## Update ALB/Target groups"
./update-targetgroups.sh
echo "# ## Return to example path"
cd ../../../
echo "# 5. App Mesh setup"
cd apps/colorapp/servicemesh
./appmesh-colorapp.sh
