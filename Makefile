.ONESHELL:
test:
	echo $(HOME)
	echo $$(which pip3)

.ONESHELL:
apt-install:
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get dist-upgrade
	sudo apt-get remove xul-ext-ubufox gedit

	for i in gnome-tweak-tool gnome-themes-standard htop kate kompare chrome-gnome-shell opam openjdk-8-jre lm-sensors synaptic gparted gimp inkscape nautilus-dropbox vlc apt-file autoconf libtool cmake net-tools sshfs libopenmpi-dev npm libcanberra-gtk-module libcanberra-gtk3-module android-tools-adb android-tools-fastboot libgirepository1.0-dev virtualbox curl gir1.2-gtop-2.0 gir1.2-networkmanager-1.0 gir1.2-clutter-1.0 rar libreoffice r-base rename pandoc aptitude; do sudo apt-get -y install $$i; done

	sudo apt-get autoremove
	sudo apt-get autoclean
	sudo apt-get clean

latex-install:
	sudo apt-get install texstudio texlive-full

install-python-packages-local:
	~/bin/local-pip3 install numpy pandas \
	cobra escher seaborn pillow bokeh dnaplotlib pysb \
	biopython --upgrade

install-python-packages-system:
	sudo apt-get -y install python3-pip python3-tk python3-h5py
	sudo -H pip3 install numpy pandas \
	cobra escher seaborn pillow bokeh dnaplotlib pysb \
	biopython --upgrade

	sudo apt-get -y install python-pip python-tk python-h5py
	sudo -H pip2 install numpy pandas \
	cobra escher seaborn pillow bokeh dnaplotlib pysb \
	biopython qiime --upgrade

	# cython makes jupyter to crush; also weave (?)

install-python-packages-developing:
	sudo -H pip3 install testresources \
	twine sphinx sphinx-autobuild sphinx_rtd_theme \
	versioneer pylint autopep8 --upgrade

	sudo -H pip2 install testresources \
	twine sphinx sphinx-autobuild sphinx_rtd_theme \
	versioneer pylint autopep8 --upgrade

conf-jupyter-system:
	sudo -H pip3 install jupyter jupyterlab ipykernel nbopen rise --upgrade

	python3 -m ipykernel install --user
	python3 -m nbopen.install_xdg

	# install and enable rise
	sudo jupyter-nbextension install rise --py --sys-prefix
	sudo jupyter-nbextension enable rise --py --sys-prefix

# 	# install and enable contrib_nbextensions
# 	sudo jupyter-nbextension install jupyter_contrib_nbextensions --py --sys-prefix
# 	sudo jupyter-nbextension enable jupyter_contrib_nbextensions --py --sys-prefix
#
# 	# install and enable nbextensions_configurator
# 	sudo jupyter-nbextension install jupyter_nbextensions_configurator --py --sys-prefix
# 	sudo jupyter-nbextension enable jupyter_nbextensions_configurator --py --sys-prefix
#
# 	# install and enable ipyparallel
# 	sudo jupyter-nbextension install --sys-prefix --py ipyparallel
# 	sudo jupyter-nbextension enable --sys-prefix --py ipyparallel
# 	sudo jupyter-serverextension enable --sys-prefix --py ipyparallel

add-jupyter-kernels:
	# compiled R from CRAN
	~/bin/R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/'); \
	library(devtools); \
	devtools::install('/opt/github-repositories/irkernel-irkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'cran')"

	# R from Canonical repository
	sudo R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/'); \
	library(devtools); \
	devtools::install('/opt/github-repositories/irkernel-irkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'ir')"

.ONESHELL:
python3.6.5:
	sudo apt-get install build-essential checkinstall
	sudo apt-get install libssl-dev zlib1g-dev libncurses5-dev \
	libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
	libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev

	wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz \
	-O $(HOME)/opt/github-repositories/ubuntu-software/Python-3.6.5.tgz
	if [ -d $(HOME)/opt/github-repositories/Python-3.6.5 ]; then rm -rf $(HOME)/opt/github-repositories/Python-3.6.5; fi
	tar xvzf $(HOME)/opt/github-repositories/ubuntu-software/Python-3.6.5.tgz -C ~/opt/github-repositories
	cd $(HOME)/opt/github-repositories/Python-3.6.5
	if [ -f Makefile ]; then make clean; fi
	if [ -d $(HOME)/opt/github-repositories/python-3.6.5 ]; then rm -rf $(HOME)/opt/github-repositories/python-3.6.5; fi
	./configure --prefix=$(HOME)/opt/github-repositories/python-3.6.5 --enable-opt/github-repositoriesimizations
	make
	make install

.ONESHELL:
python3.7.0:
	sudo apt-get install build-essential checkinstall
	sudo apt-get install libssl-dev zlib1g-dev libncurses5-dev \
	libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
	libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev uuid-dev

	wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz \
	-O $(HOME)/opt/github-repositories/ubuntu-software/Python-3.7.0.tgz
	if [ -d $(HOME)/opt/github-repositories/Python-3.7.0 ]; then rm -rf $(HOME)/opt/github-repositories/Python-3.7.0; fi
	tar xvzf $(HOME)/opt/github-repositories/ubuntu-software/Python-3.7.0.tgz -C ~/opt/github-repositories
	cd $(HOME)/opt/github-repositories/Python-3.7.0
	if [ -f Makefile ]; then make clean; fi
	if [ -d $(HOME)/opt/github-repositories/python-3.7.0 ]; then rm -rf $(HOME)/opt/github-repositories/python-3.7.0; fi
	./configure --prefix=$(HOME)/opt/github-repositories/python-3.7.0 --enable-opt/github-repositoriesimizations
	make
	make install

.ONESHELL:
r3.5.0:
	sudo apt-get install libcairo2-dev libxt-dev libtiff5-dev libssh2-1-dev libxml libxml2-dev

	wget https://cloud.r-project.org/bin/linux/ubuntu/bionic-cran35/r-base_3.5.0.orig.tar.gz \
	-O $(HOME)/opt/github-repositories/ubuntu-software/R-3.5.0.tgz
	if [ -d $(HOME)/opt/github-repositories/R-3.5.0 ]; then rm -rf $(HOME)/opt/github-repositories/R-3.5.0; fi
	tar xvzf $(HOME)/opt/github-repositories/ubuntu-software/R-3.5.0.tgz -C $(HOME)/opt/github-repositories
	cd $(HOME)/opt/github-repositories/R-3.5.0
	if [ -f Makefile ]; then make clean; fi
	if [ -d $(HOME)/opt/github-repositories/r-3.5.0 ]; then rm -rf $(HOME)/opt/github-repositories/r-3.5.0; fi
	./configure --prefix=$(HOME)/opt/github-repositories/r-3.5.0 --enable-R-shlib --with-blas --with-lapack
	make
	make install

install-r-packages-local:
	~/bin/R -e "install.packages('tidyverse', dependencies = TRUE)"
	~/bin/R -e "install.packages('knitr', dependencies = TRUE)"
	~/bin/R -e "install.packages('rmarkdown', dependencies = TRUE)"
	~/bin/R -e "install.packages('gridExtra', dependencies = TRUE)"
	~/bin/R -e "install.packages('plotly', dependencies = TRUE)"
	~/bin/R -e "install.packages('Cairo', dependencies = TRUE)"
	~/bin/R -e "install.packages('ggpubr', dependencies = TRUE)"
	~/bin/R -e "install.packages('ape', dependencies = TRUE)"
	~/bin/R -e "install.packages('biom', dependencies = TRUE)"
	~/bin/R -e "install.packages('opt/github-repositoriesparse', dependencies = TRUE)"
	~/bin/R -e "install.packages('RColorBrewer', dependencies = TRUE)"
	~/bin/R -e "install.packages('randomForest', dependencies = TRUE)"
	~/bin/R -e "install.packages('vegan', dependencies = TRUE)"

	# install bioConductor packages
	~/bin/R -e "source('https://bioconductor.org/biocLite.R'); \
	biocLite(); \
	biocLite('dada2'); \
	biocLite('phyloseq'); \
	biocLite('DESeq2'); \
	biocLite('microbiome'); \
	biocLite('metagenomeSeq')"

# .ONESHELL:
# update-python3-packages:
# 	sudo $$(which pip3) list --outdated --format=columns \
# 	| tail -n +3 | cut -d ' ' -f 1 | \
# 	sudo -H xargs -n1 $$(which pip3) install --upgrade

# .ONESHELL:
# update-python2-packages:
# 	sudo $$(which pip) list --outdated --format=columns \
# 	| tail -n +3 | cut -d ' ' -f 1 | \
# 	sudo -H xargs -n1 $$(which pip) install --upgrade

clone-github-repositories:
	sudo chown -R glucksfall:glucksfall /opt
	
	# clone
	git clone https://github.com/20n/act.git \
	/opt/github-repositories/20n.act

	git clone https://github.com/3DGenomes/TADbit.git \
	/opt/github-repositories/3DGenomes.TADbit

	git clone https://github.com/bmbolstad/RMAExpress.git \
	/opt/github-repositories/bmbolstad.RMAExpress_1_1_0 --branch RMAExpress_1_1_0

	git clone https://github.com/bmbolstad/RMAExpress.git \
	/opt/github-repositories/bmbolstad.RMAExpress

	git clone https://github.com/borenstein-lab/CoMiDA.git \
	/opt/github-repositories/borenstein-lab.CoMiDA

	git clone https://github.com/CovertLab/WholeCellViz.git \
	/opt/github-repositories/CovertLab.WholeCellViz

	git clone https://github.com/cryptoluka/CryptoLuKa.git \
	/opt/github-repositories/cryptoluka.CryptoLuKa

	git clone https://github.com/DLab/PISKaS.git \
	/opt/github-repositories/DLab.PISKaS

	git clone https://github.com/ethereum/go-ethereum.git \
	/opt/github-repositories/ethereum.go-ethereum

	git clone https://github.com/google/skicka.git \
	/opt/github-repositories/google.skicka

	git clone https://github.com/hyattpd/Prodigal.git \
	/opt/github-repositories/hyattpd.Prodigal

	git clone https://github.com/jhcepas/eggnog-mapper.git \
	/opt/github-repositories/jhcepas.eggnog-mapper

	git clone https://github.com/JuliaLang/IJulia.jl.git \
	/opt/github-repositories/JuliaLang.IJulia

	git clone https://github.com/Kappa-Dev/KaSim.git \
	/opt/github-repositories/Kappa-Dev.KaSim3 --branch KaSim3

	git clone https://github.com/Kappa-Dev/KaSim.git \
	/opt/github-repositories/Kappa-Dev.KaSim4 --branch KaSim4

	git clone https://github.com/Kappa-Dev/KaSim.git \
	/opt/github-repositories/Kappa-Dev.KaSim

	git clone https://github.com/naxo100/PISKa.git \
	/opt/github-repositories/naxo100.PISKa

	git clone https://github.com/opencobra/cobratoolbox.git \
	/opt/github-repositories/opencobra.cobratoolbox

	git clone https://github.com/PosnerLab/BioNetFit.git \
	/opt/github-repositories/PosnerLab.BioNetFit

	git clone https://github.com/RuleWorld/BioNetFit.git \
	/opt/github-repositories/RuleWorld.BioNetFit

	git clone https://github.com/RuleWorld/bionetgen.git \
	/opt/github-repositories/RuleWorld.bionetgen

	git clone https://github.com/RuleWorld/rulebender.git \
	/opt/github-repositories/RuleWorld.rulebender

	git clone https://github.com/salilab/imp.git \
	/opt/github-repositories/salilab.imp

	git clone https://github.com/sbmlteam/SBMLToolbox.git \
	/opt/github-repositories/sbmlteam.SBMLToolbox

	git clone https://github.com/SchedMD/slurm.git \
	/opt/github-repositories/SchedMD.slurm

	git clone https://github.com/StochSS/StochKit.git \
	/opt/github-repositories/StochSS.StochKit

	git clone https://github.com/SysBioChalmers/RAVEN.git \
	/opt/github-repositories/SysBioChalmers.RAVEN

slurm-conf:
	sudo apt-get -y install slurm-wlm
	sudo nano /etc/slurm-llnl/slurm.conf

	sudo chown -R slurm:slurm /var/run/slurm-llnl/
	sudo chown -R slurm:slurm /var/lib/slurm-llnl/
	sudo chown -R slurm:slurm /var/log/slurm-llnl/
	sudo mkdir /var/spool/slurmd
	sudo chown -R slurm:slurm /var/spool/slurmd

#	sudo apt-get install mariadb-server
#	sudo systemctl enable mysql
#	sudo systemctl start mysql
#	sudo mysql -u root
# 	create database slurm_acct_db;
# 	create user 'slurm'@'localhost';
# 	set password for 'slurm'@'localhost' = password('slurmdbpass');
# 	grant usage on *.* to 'slurm'@'localhost';
# 	grant all privileges on slurm_acct_db.* to 'slurm'@'localhost';
# 	flush privileges;
# 	exit

.ONESHELL:
install-others:
	cd /opt/ubuntu-software/

	sudo dpkg -i gitter_3.1.0_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	sudo dpkg -i mendeleydesktop_1.17.13-stable_amd64.deb
	sudo dpkg -i prey_1.6.5_amd64.deb
	sudo dpkg -i snapgene_viewer_4.1.9_linux.deb
	sudo dpkg -i whatsie-2.1.0-linux-amd64.deb

	sudo chown -R glucksfall:glucksfall /opt

	sudo apt-get install -f
	sudo apt-file update

	Anaconda3-5.1.0-Linux-x86_64.sh
	Cytoscape_3_5_1_unix.sh
	pathway-tools-21.0-linux-64-tier1-install

	tar xvzf gurobi7.5.2_linux64.tar.gz -C /opt
	tar xvzf COPASI-4.23.184-Linux-64bit.tar.gz -C /opt

.ONESHELL:
install-matlab:
	cd /opt/ubuntu-software/

	if [[ ! -d /opt/matlab_R2017b_glnxa64 ]]; \
	then unzip matlab_R2017b_glnxa64.zip -d /opt/matlab_R2017b_glnxa64; \
	fi

	cd /opt/matlab_R2017b_glnxa64
	install
