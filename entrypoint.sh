#!/bin/bash

dir=/certs/actions
workdir=/ac-patrick/easy-rsa/

ca.crt(){
    dircerts=/certs
    cacert=$dir/cacert
    cp $dircerts/ca.crt $cacert/ && chown patrick.patrick $cacert/ca.crt
}

sign.server(){
    signdir=$dir/sign
    signeddir=/ac-patrick/easy-rsa/pki/issued
    reqsign=$(ls $signdir)
    for i in $reqsign; do
        filename="${i%.*}"
        certname="$filename-server"
        signedname="$certname.crt"
        cd $workdir
        bash easyrsa import-req $signdir/$i $certname
        bash easyrsa sign-req server kali-server
        cp $signeddir/$signedname $signdir/$signedname && chown patrick.patrick $signdir/$signedname
    done
}

sign.client(){
    signdir=$dir/sign
    signeddir=/ac-patrick/easy-rsa/pki/issued
    reqsign=$(ls $signdir)
    for i in $reqsign; do
        filename="${i%.*}"
        certname="$filename-client"
        signedname="$certname.crt"
        cd $workdir
        bash easyrsa import-req $signdir/$i $certname
        bash easyrsa sign-req client "$certname"
        cp $signeddir/$signedname $signdir/$signedname && chown patrick.patrick $signdir/$signedname
    done
}

revoke(){
    revokedir=$dir/revoke
    revoke=$(ls $revokedir)
    for i in $revoke; do
        cd $workdir
        bash easyrsa import-req $revokedir/$i $i
        bash easyrsa revoke $i
        cp $revokedir/$i $revokedir/$i && chown patrick.patrick $revokedir/$i
    done
}

if [ $1 == 'sign' ] && [ $2 == 'server' ]; then
    sign.server

elif [ $1 == 'sign' ] && [ $2 == 'client' ]; then
    sign.client

elif [ $1 == 'revoke' ]; then
    revoke

else
    ca.crt
fi