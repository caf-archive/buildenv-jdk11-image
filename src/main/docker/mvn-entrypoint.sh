#! /bin/sh -eu
#
# Copyright 2018 Micro Focus or one of its affiliates.
#
# The only warranties for products and services of Micro Focus and its
# affiliates and licensors ("Micro Focus") are set forth in the express
# warranty statements accompanying such products and services. Nothing
# herein should be construed as constituting an additional warranty.
# Micro Focus shall not be liable for technical or editorial errors or
# omissions contained herein. The information contained herein is subject
# to change without notice.
#
# Contains Confidential Information. Except as specifically indicated
# otherwise, a valid license is required for possession, use or copying.
# Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
# Computer Software Documentation, and Technical Data for Commercial
# Items are licensed to the U.S. Government under vendor's standard
# commercial license.
#


# Copy files from /usr/share/maven/ref into ${MAVEN_CONFIG}
# So the initial ~/.m2 is set with expected content.
# Don't override, as this is just a reference setup

copy_reference_files() {
  local log="$MAVEN_CONFIG/copy_reference_file.log"
  local ref="/usr/share/maven/ref"

  if mkdir -p "${MAVEN_CONFIG}/repository" && touch "${log}" > /dev/null 2>&1 ; then
      cd "${ref}"
      local reflink=""
      if cp --help 2>&1 | grep -q reflink ; then
          reflink="--reflink=auto"
      fi
      if [ -n "$(find "${MAVEN_CONFIG}/repository" -maxdepth 0 -type d -empty 2>/dev/null)" ] ; then
          # destination is empty...
          echo "--- Copying all files to ${MAVEN_CONFIG} at $(date)" >> "${log}"
          cp -rv ${reflink} . "${MAVEN_CONFIG}" >> "${log}"
      else
          # destination is non-empty, copy file-by-file
          echo "--- Copying individual files to ${MAVEN_CONFIG} at $(date)" >> "${log}"
          find . -type f -exec sh -eu -c '
              log="${1}"
              shift
              reflink="${1}"
              shift
              for f in "$@" ; do
                  if [ ! -e "${MAVEN_CONFIG}/${f}" ] || [ -e "${f}.override" ] ; then
                      mkdir -p "${MAVEN_CONFIG}/$(dirname "${f}")"
                      cp -rv ${reflink} "${f}" "${MAVEN_CONFIG}/${f}" >> "${log}"
                  fi
              done
          ' _ "${log}" "${reflink}" {} +
      fi
      echo >> "${log}"
  else
    echo "Can not write to ${log}. Wrong volume permissions? Carrying on ..."
  fi
}

owd="$(pwd)"
copy_reference_files
unset MAVEN_CONFIG

cd "${owd}"
unset owd

exec "$@"