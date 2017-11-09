# Universal file writer

Code for writing unv files for geometry (data type 15) and modes (data
type 55). 

Consists in 4 files, two functions and two scripts:

## Functions

* `unvWriter`: writes unv file containing geometry given the name of
  the file and the coordinates of the nodes
  
* `modosUnv`: writes unv file containing a mode. Info about the
  frequency, damping, mode number... has to be given

## Scripts

* `creadorPuntos`: an example for using the geometry writer 
* `pruebaModos`: an example for testing `modosUnv`

## References

[File-Format-Storehouse](http://www.sdrl.uc.edu/sdrl/referenceinfo/universalfileformats/file-format-storehouse/)

[Test Universal Files (pdf)](http://www.sdrl.uc.edu/sdrl/referenceinfo/universalfileformats/file-format-storehouse/test_universal_file_formats.pdf)

[UFF File Reading and Writing in Matlab](http://es.mathworks.com/matlabcentral/fileexchange/6395-uff-file-reading-and-writing)

[The Fortran format](http://pages.mtu.edu/~shene/COURSES/cs201/NOTES/chap05/format.html)
