#!/bin/bash

echo "Ingrese el nombre del grupo IAM:"
read groupname

echo "Ingrese el nombre del usuario IAM:"
read username

# Crear el grupo IAM
aws iam create-group --group-name $groupname

# Adjuntar políticas al grupo IAM
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name $groupname
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name $groupname
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name $groupname
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name $groupname
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name $groupname
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonSQSFullAccess --group-name $groupname
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess --group-name $groupname

# Crear el usuario IAM
aws iam create-user --user-name $username

# Agregar el usuario al grupo IAM
aws iam add-user-to-group --user-name $username --group-name $groupname

# Crear una clave de acceso para el usuario IAM
aws iam create-access-key --user-name $username
