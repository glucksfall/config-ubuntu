SHELL := /bin/bash
HOST=$(shell hostname)

export D1=$(HOME)

export PYTHON3_PACKAGES=pip numpy pandas nose python-libsbml \
	cobra escher seaborn pillow bokeh dnaplotlib pysb \
	biopython openpyxl xlrd fastcluster scikit-bio \
	scikit-learn rpy2 tzlocal

export PYTHON2_PACKAGES=pip qiime

export DEV_PYTHON_PACKAGES=testresources twine sphinx sphinx-autobuild \
	sphinx_rtd_theme versioneer pylint autopep8

export CUDA_PYTHON3_PACKAGES=pycuda scikit-cuda \
	torchvision tensorflow-gpu theano cntk-gpu

export JUPYTER_PACKAGES=jupyter jupyterlab ipykernel nbopen rise

export PERL_PACKAGES=JSON Math::CDF HTML::Template XML::Compile::SOAP11 \
	XML::Compile::WSDL11 XML::Compile::Transport::SOAPHTTP

export BIOCONDUCTOR=dada2 edgeR phyloseq DESeq DESeq2 microbiome \
	BiocVersion ggtree graph hypergraph treeio metagenomeSeq

.ONESHELL:
test:
	echo $(HOME)
	echo $$(which pip3)
	echo $(HOST)

.ONESHELL:
apt-install:
	sudo apt update
	sudo apt -y upgrade
	sudo apt -y dist-upgrade
	sudo apt -y remove xul-ext-ubufox gedit

	APTS="gnome-tweak-tool gnome-themes-standard htop kate kompare \
	chrome-gnome-shell opam openjdk-8-jre lm-sensors synaptic gparted gimp \
	inkscape nautilus-dropbox vlc apt-file autoconf libtool cmake net-tools \
	sshfs libopenmpi-dev npm libcanberra-gtk-module libcanberra-gtk3-module \
	android-tools-adb android-tools-fastboot libgirepository1.0-dev \
	virtualbox curl gir1.2-gtop-2.0 gir1.2-networkmanager-1.0 \
	gir1.2-clutter-1.0 rar libreoffice r-base rename pandoc aptitude \
	sra-toolkit libxm4 pdfshuffler ttf-mscorefonts-installer openssh-server \
	nfs-common nfs-kernel-server ghostscript libcurl4-openssl-dev \
	openjdk-11-jdk-headless python-pip"

	PYTHON3_DEPS="python3-pip python3-tk python3-h5py build-essential \
	checkinstall libssl-dev zlib1g-dev libncurses5-dev \
	libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
	libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev uuid-dev"

	R_DEPS="libcairo2-dev libxt-dev libtiff5-dev libssh2-1-dev libxml2 libxml2-dev"

	for apt in $$APTS; do sudo apt -y install $$apt; done
	for apt in $$PYTHON3_DEPS; do sudo apt -y install $$apt; done
	for apt in $$R_DEPS; do sudo apt -y install $$apt; done

	sudo apt -y autoremove
	sudo apt -y autoclean
	sudo apt -y clean

latex-install:
	sudo apt-get -y install texstudio texlive-full

system-perl-packages-install:
	sudo cpan $$PERL_PACKAGES

system-pip3-install:
	for package in $$PYTHON3_PACKAGES; do \
		sudo -H pip3 install $$package --upgrade;
		sudo -H pip3 install $$package --upgrade; done

	for package in $$DEV_PACKAGES; do \
		sudo -H pip3 install $$package --upgrade;
		sudo -H pip3 install $$package --upgrade; done

local-pip3-install:
	for package in $$PYTHON3_PACKAGES; do \
		$$D1/opt/python-3.6.5/bin/pip3 install $$package --upgrade;
		$$D1/opt/python-3.7.0/bin/pip3 install $$package --upgrade; done

	for package in $$DEV_PACKAGES; do \
		$$D1/opt/python-3.6.5/bin/pip3 install $$package --upgrade;
		$$D1/opt/python-3.7.0/bin/pip3 install $$package --upgrade; done

cuda-install:
	cd $$D1/opt/ubuntu-software

	sudo apt -y install linux-headers-$(uname -r)
	sudo dpkg -i cuda-repo-ubuntu1804-10-0-local-10.0.130-410.48_1.0-1_amd64.deb
	sudo apt-key add /var/cuda-repo-10-0-local-10.0.130-410.48/7fa2af80.pub
	sudo apt update
	sudo apt -y install cuda
	CUDA_APTS="cuda-toolkit-10-0 cuda-tools-10-0 cuda-runtime-10-0 \
	cuda-compiler-10-0 cuda-libraries-10-0 cuda-libraries-dev-10-0 \
	cuda-drivers nvidia-cuda-toolkit"
	for apt in $$CUDA_APTS; do sudo apt -y install $$apt; done
	sudo dpkg -i libcudnn7_7.3.1.20-1+cuda10.0_amd64.deb \
	libcudnn7-dev_7.3.1.20-1+cuda10.0_amd64.deb libcudnn7-doc_7.3.1.20-1+cuda10.0_amd64.deb

local-cuda-pip3-install:
	$$D1/opt/python-3.6.5/bin/pip3 install https://download.pytorch.org/whl/cu100/torch-1.0.1.post2-cp36-cp36m-linux_x86_64.whl
	$$D1/opt/python-3.7.0/bin/pip3 install https://download.pytorch.org/whl/cu100/torch-1.0.1.post2-cp37-cp37m-linux_x86_64.whl

	for package in $$CUDA_PYTHON3_PACKAGES; do \
		$$D1/opt/python-3.6.5/bin/pip3 install $$package --upgrade;
		$$D1/opt/python-3.7.0/bin/pip3 install $$package --upgrade; done

local-jupyter-install:
	for package in $$JUPYTER_PACKAGES; do \
		$$D1/opt/python-3.6.5/bin/pip3 install $$package --upgrade;
		$$D1/opt/python-3.7.0/bin/pip3 install $$package --upgrade; done

	# install python3.6.5 kernel
	$$D1/opt/python-3.6.5/bin/python3 -m ipykernel install --user
	$$D1/opt/python-3.6.5/bin/python3 -m nbopen.install_xdg

	# install and enable rise
	$$D1/opt/python-3.6.5/bin/jupyter-nbextension install rise --py --sys-prefix
	$$D1/opt/python-3.6.5/bin/jupyter-nbextension enable rise --py --sys-prefix

.ONESHELL:
python3.6.5-compile:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz \
	-O $$D1/opt/ubuntu-software/Python-3.6.5.tgz
	if [ -d $$D1/opt/Python-3.6.5 ]; then rm -rf $$D1/opt/Python-3.6.5; fi
	tar xvzf $$D1/opt/ubuntu-software/Python-3.6.5.tgz -C $$D1/opt
	cd $$D1/opt/Python-3.6.5
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/python-3.6.5 ]; then rm -rf $$D1/opt/python-3.6.5; fi
	./configure --prefix=$$D1/opt/python-3.6.5 --enable-optimizations
	make
	make install

.ONESHELL:
python3.7.0-compile:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz \
	-O $$D1/opt/ubuntu-software/Python-3.7.0.tgz
	if [ -d $$D1/opt/Python-3.7.0 ]; then rm -rf $$D1/opt/Python-3.7.0; fi
	tar xvzf $$D1/opt/ubuntu-software/Python-3.7.0.tgz -C $$D1/opt
	cd $$D1/opt/Python-3.7.0
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/python-3.7.0 ]; then rm -rf $$D1/opt/python-3.7.0; fi
	./configure --prefix=$$D1/opt/python-3.7.0 --enable-optimizations
	make
	make install

.ONESHELL:
r-3.5.0-compile:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://cloud.r-project.org/bin/linux/ubuntu/bionic-cran35/r-base_3.5.0.orig.tar.gz \
	-O $$D1/opt/ubuntu-software/R-3.5.0.tgz
	if [ -d $$D1/opt/R-3.5.0 ]; then rm -rf $$D1/opt/R-3.5.0; fi
	tar xvzf $$D1/opt/ubuntu-software/R-3.5.0.tgz -C $$D1/opt
	cd $$D1/opt/R-3.5.0
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/r-3.5.0 ]; then rm -rf $$D1/opt/r-3.5.0; fi
	./configure --prefix=$$D1/opt/r-3.5.0 --enable-R-shlib --with-blas --with-lapack
	make
	make install

.ONESHELL:
r-3.5.2-compile:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://cloud.r-project.org/bin/linux/ubuntu/bionic-cran35/r-base_3.5.2.orig.tar.gz \
	-O $$D1/opt/ubuntu-software/R-3.5.2.tgz
	if [ -d $$D1/opt/R-3.5.2 ]; then rm -rf $$D1/opt/R-3.5.2; fi
	tar xvzf $$D1/opt/ubuntu-software/R-3.5.2.tgz -C $$D1/opt
	cd $$D1/opt/R-3.5.2
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/r-3.5.2 ]; then rm -rf $$D1/opt/r-3.5.2; fi
	./configure --prefix=$$D1/opt/r-3.5.2 --enable-R-shlib --with-blas --with-lapack
	make
	make install

export BIOCONDUCTOR=dada2 edgeR phyloseq DESeq DESeq2 microbiome \
	BiocVersion ggtree graph hypergraph treeio metagenomeSeq

export R_PACKAGES=tidyverse knitr rmarkdown gridExtra plotly Cairo ggpubr ape \
	biom optparse RColorBrewer randomForest vegan apcluster chron compare compute.es \
	d3heatmap dendextend DEoptimR diptest fastmatch flexmix fpc kernlab mclust mds \
	modeltools mvtnorm NLP phangorn pheatmap plotrix PMCMR png prabclus \
	qdapDictionaries qdapRegex quadprog rafalib reports robustbase rvcheck segmented \
	seqinr slam tidytree  trimcluster UpSetR wordcloud

local-r-libraries-install:
	# install R packages
	for package in $$R_PACKAGES; do $$D1/bin/R -e \
		"install.packages('$$package', dependencies = TRUE, repos = 'https://cloud.r-project.org/')"; done

	# install Bioconductor packages
	$$D1/bin/R -e \
		"if (!requireNamespace(\"BiocManager\", quietly = TRUE)) \
		install.packages(\"BiocManager\", dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	for package in $$BIOCONDUCTOR; do $$D1/bin/R -e "BiocManager::install(\"$$package\", version = \"3.8\")"; done

.ONESHELL:
r-kernels-jupyter:
	$$D1/bin/R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('/opt/github-repositories/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'cran')"

	sudo R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('/opt/github-repositories/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'ir')"

.ONESHELL:
slurm-install:
	sudo apt-get -y remove --purge munge slurm-wlm slurmdbd
	sudo apt-get -y autoremove
	sudo apt-get -y install munge slurm-wlm slurmdbd

.ONESHELL:
slurm-conf:
	sudo systemctl stop munge
	sudo systemctl stop slurmd
	sudo systemctl stop slurmctld
	sudo systemctl stop slurmdbd

	sudo rm -rf /var/lib/slurm-llnl /var/run/slurm-llnl /var/log/slurm-llnl

	sudo mkdir -p /var/spool/slurmd
	sudo mkdir -p /var/lib/slurm-llnl
	sudo mkdir -p /var/lib/slurm-llnl/slurmd
	sudo mkdir -p /var/lib/slurm-llnl/slurmctld
	sudo mkdir -p /var/run/slurm-llnl
	sudo mkdir -p /var/log/slurm-llnl

	sudo chmod -R 755 /var/spool/slurmd
	sudo chmod -R 755 /var/lib/slurm-llnl/
	sudo chmod -R 755 /var/run/slurm-llnl/
	sudo chmod -R 755 /var/log/slurm-llnl/

	sudo chown -R slurm:slurm /var/spool/slurmd
	sudo chown -R slurm:slurm /var/lib/slurm-llnl/
	sudo chown -R slurm:slurm /var/run/slurm-llnl/
	sudo chown -R slurm:slurm /var/log/slurm-llnl/

	sudo cp slurm.conf gres.conf /etc/slurm-llnl/

	sudo rsync -avu -P munge.key /etc/munge/munge.key
	sudo chown munge:munge /etc/munge/munge.key
	sudo chmod 400 /etc/munge/munge.key
	sudo chmod 711 /var/lib/munge/
	sudo chmod 755 /var/run/munge/

	sudo systemctl restart munge
	sudo service munge status

	sudo systemctl restart slurmd
	sudo service slurmd status

	if [ "$(HOST)" = "spica" ] ; then
		sudo systemctl restart slurmctld
		sudo service slurmctld status
	else
		sudo systemctl stop slurmctld
		sudo service slurmctld status
	fi

.ONESHELL:
others-install:
	cd $$D1/opt/ubuntu-software/

	sh Anaconda3-5.3.0-Linux-x86_64.sh
	sh cplex_studio128.linux-x86-64.bin
	sh Cytoscape_3_7_0_unix.sh

	PTOOLS="pathway-tools-21.5-linux-64-tier1-install"
	chmod u+x $(PTOOLS); ./$(PTOOLS); chmod u-x $(PTOOLS)

	tar xvzf COPASI-4.24.197-Linux-64bit.tar.gz -C $$D1/opt
	tar xvzf gurobi8.0.1_linux64.tar.gz -C $$D1/opt
