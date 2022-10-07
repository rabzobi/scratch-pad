export VERSION=31.0.0-SNAPSHOT
export OMNS_SRC=$HOME/opennms
export OMNS_HOME=$HOME/opennms/target/opennms-$VERSION
export URL=http://localhost:8980/opennms

export OPENNMS_SRC=$OMNS_SRC
export OPENNMS_HOME=$OMNS_HOME

function deploy(){
	SRC=$1
	DEST=$2
	if [ -z " $SRC" ] ; then
		"No SRC given, no deploy but start will continue.."
	else
		if [ -z " $DEST" ] ; then
			"No DEST given, no deploy but start will continue.."	
		else
			echo "---Source---"
			ls -l $SRC		
			echo "---Destination---"
			ls -l $DEST
			cp -f $SRC $DEST
			if [ $? -eq 0 ] ; then
				echo "Copy ok! :-)"
			else
				echo "Copy failed :~("
				exit 1
			fi
		fi
	fi
}

