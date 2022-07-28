#! /bin/bash
wifi="$(ip a | grep wlo1 | grep inet | wc -l)"
					if [ $wifi = 1 ] || [ $wifi = 2 ]; then
						echo "直"
					else 
						echo "睊"
					fi
