#!/bin/bash

echo "Enter the IAM group and user name:"
read username

# Crear el grupo IAM
aws iam create-group --group-name $username

# Adjuntar políticas al grupo IAM
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name $username
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name $username
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name $username
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name $username
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name $username
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonSQSFullAccess --group-name $username
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess --group-name $username

# Crear el usuario IAM
aws iam create-user --user-name $username

# Agregar el usuario al grupo IAM
aws iam add-user-to-group --user-name $username --group-name $username

# Crear una clave de acceso para el usuario IAM
aws iam create-access-key --user-name $username
