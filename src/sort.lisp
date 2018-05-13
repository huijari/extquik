(include <stdbool.h>)
(include <stdio.h>)
(include "mem.h")

;; Copy the contents of a file to another file
;; @param source Source file
;; @param destination Destination file
;; @param chunkSize Size of each chunk to be copied, in kilobytes
(function fcopy ((FILE* source)
								 (FILE* destination)
								 (unsigned int chunkSize)) -> void
	(rewind source)
	(rewind destination)

	(decl ((size_t size = (* 1024 chunkSize))
				 (char* buffer = (mathias_malloc size))
				 (int bytesRead)))
	(while (> (set bytesRead (fread buffer 1 size source)) 0)
		(fwrite buffer 1 bytesRead destination))

	(mathias_free buffer)
	(rewind source)
	(rewind destination))

;; Returns true the first string is valued "less" than the second
;; @param a First string
;; @param b Second string
(function a_menor_que_b ((char* a)
												 (char* b)
												 (int length)) -> int
	(for ((int i = 0) (< i length) i++)
		(if (< a[i] b[i]) (return true))
		(if (> a[i] b[i]) (return false)))
	(return false))

;; Sort a file and output the content to another file, using a maximum
;; of memory indicated by the user
;; @param inputPath Path to the input file
;; @param outputPath Path to the output file
;; @param memory Maximum memory to be allocated, in kilobytes
(function external_sort ((const char* inputPath)
												 (const char* outputPath)
												 (unsigned int memory)) -> void
	(decl ((FILE* input = (fopen inputPath "r"))
				 (FILE* output = (fopen outputPath "rw"))))
	(fcopy input output memory)

	(fclose input)
	(fclose output))
