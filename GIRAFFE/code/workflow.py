#This is a Nipype generator. Warning, here be dragons.
#!/usr/bin/env python

import sys
import nipype
import nipype.pipeline as pe

import nipype.interfaces.fsl as fsl
import nipype.interfaces.io as io
import nipype.interfaces.afni as afni
import nipype.interfaces.ants as ants

#Wraps command **bet**
fsl_BET = pe.Node(interface = fsl.BET(), name='fsl_BET')

#Extension of DataGrabber module that downloads the file list and
io_SSHDataGrabber_anat = pe.Node(interface = io.SSHDataGrabber(), name='io_SSHDataGrabber_anat')

#Extension of DataGrabber module that downloads the file list and
io_SSHDataGrabber_EPI = pe.Node(interface = io.SSHDataGrabber(), name='io_SSHDataGrabber_EPI')

#Wraps the executable command ``3dUnifize``.
afni_Unifize = pe.Node(interface = afni.Unifize(), name='afni_Unifize')

#Wraps the executable command ``3dDespike``.
afni_Despike = pe.Node(interface = afni.Despike(), name='afni_Despike')

#Wraps the executable command ``3dTcat``.
afni_TCat = pe.Node(interface = afni.TCat(), name='afni_TCat')

#Wraps the executable command ``3dvolreg``.
afni_Volreg = pe.Node(interface = afni.Volreg(), name='afni_Volreg')

#Wraps the executable command ``antsRegistrationSyNQuick.sh``.
ants_RegistrationSynQuick_anat2epi = pe.Node(interface = ants.RegistrationSynQuick(), name='ants_RegistrationSynQuick_anat2epi')

#Wraps the executable command ``antsRegistration``.
ants_Registration = pe.Node(interface = ants.Registration(), name='ants_Registration')

#Extension of DataGrabber module that downloads the file list and
io_SSHDataGrabber_MNItemp = pe.Node(interface = io.SSHDataGrabber(), name='io_SSHDataGrabber_MNItemp')

#Create a workflow to connect all those nodes
analysisflow = nipype.Workflow('MyWorkflow')
analysisflow.connect(afni_TCat, "out_file", afni_Despike, "in_file")
analysisflow.connect(afni_Unifize, "out_file", fsl_BET, "in_file")
analysisflow.connect(afni_Despike, "out_file", afni_Volreg, "in_file")
analysisflow.connect(fsl_BET, "out_file", ants_RegistrationSynQuick_anat2epi, "fixed_image")
analysisflow.connect(afni_Volreg, "out_file", ants_RegistrationSynQuick_anat2epi, "moving_image")
analysisflow.connect(ants_RegistrationSynQuick_anat2epi, "warped_image", ants_Registration, "moving_image")

#Run the workflow
plugin = 'MultiProc' #adjust your desired plugin here
plugin_args = {'n_procs': 1} #adjust to your number of cores
analysisflow.write_graph(graph2use='flat', format='png', simple_form=False)
analysisflow.run(plugin=plugin, plugin_args=plugin_args)
