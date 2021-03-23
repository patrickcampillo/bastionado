#!/bin/bash

dir=/certs/actions
workdir=/ac-patrick/easy-rsa/
dircerts=/certs
cacert=$dir/cacert

ca.crt(){
    cp $dircerts/ca.crt $cacert/ && chmod 644 $cacert/ca.crt
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
        /bin/sh ./easyrsa import-req $signdir/$i $certname
        /bin/sh ./easyrsa sign-req server $certname
        cp $signeddir/$signedname $signdir/$signedname && chmod 644 $signdir/$signedname
    done
    if ! [ -f $cacert/ca.crt ]; then
        cp $dircerts/ca.crt $cacert/ && chmod 644 $cacert/ca.crt
    fi
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
        /bin/sh ./easyrsa import-req $signdir/$i $certname
        /bin/sh ./easyrsa sign-req client $certname
        cp $signeddir/$signedname $signdir/$signedname && chmod 644 $signdir/$signedname
    done
    if ! [ -f $cacert/ca.crt ]; then
        cp $dircerts/ca.crt $cacert/ && chmod 644 $cacert/ca.crt
    fi
}

revoke(){
    revokedir=$dir/revoke
    revoke=$(ls $revokedir)
    for i in $revoke; do
        cd $workdir
        /bin/sh ./easyrsa import-req $revokedir/$i $i
        /bin/sh ./easyrsa revoke $i
        cp $revokedir/$i $revokedir/$i && chmod 644 $revokedir/$i
    done
}

if [ $1 == 'sign' ] && [ $2 == 'server' ]; then
    sign.server

elif [ $1 == 'sign' ] && [ $2 == 'client' ]; then
    sign.client

elif [ $1 == 'revoke' ]; then
    revoke

elif [ $1 == 'ca' ]; then
    ca.crt
fi