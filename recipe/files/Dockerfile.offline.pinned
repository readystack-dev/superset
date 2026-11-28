# GENERATED L-009 hermetic Python build (--network=none, SBOM+SLSA-attestation-producing).
# Pinned base from BASE_IMAGE_DIGESTS.lock; vendored wheelhouse + source + debs from Dockerfile.vendor.
# pydeps sub-stage installs the wheelhouse offline; COPY /deps /usr/local keeps pip OUT of the runtime SBOM.
# CPython 3.12.16 COMPILED HERE, offline, from python.org's tarball (sha256 re-checked) and the vendored
# build debs, by the same command the vendor stage ran; linked against Ubuntu's libraries (debs the scan
# sees, apt fixes). The runtime takes /usr/local from this stage and none of the toolchain.
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289 AS cpython
ARG SOURCE_DATE_EPOCH=1795644313
ENV SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH}
COPY vendored/python/debs/ /tmp/cpython-debs/
COPY vendored/python/Python-3.12.16.tar.xz /tmp/Python-3.12.16.tar.xz
RUN set --; for f in /tmp/cpython-debs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; } && \
    : "${SOURCE_DATE_EPOCH:?the CPython build needs SOURCE_DATE_EPOCH}" && \
    echo "b5796915dc45ff745cfb4e990a7e7c93d6f546328a102ce31448d69ebc37575c  /tmp/Python-3.12.16.tar.xz" | sha256sum -c - && \
    mkdir -p /usr/src/python && tar -xJf /tmp/Python-3.12.16.tar.xz -C /usr/src/python --strip-components=1 --no-same-owner && \
    rm -rf /tmp/cpython-debs /tmp/Python-3.12.16.tar.xz && cd /usr/src/python && \
    export DEB_BUILD_MAINT_OPTIONS=optimize=-lto && \
    PYCF="$(dpkg-buildflags --get CFLAGS) $(dpkg-buildflags --get CPPFLAGS)" && PYLD="$(dpkg-buildflags --get LDFLAGS)" && \
    ./configure --build=x86_64-linux-gnu --prefix=/usr/local --enable-shared --enable-loadable-sqlite-extensions --enable-option-checking=fatal --disable-test-modules --without-static-libpython --with-ensurepip=install --with-system-expat --without-system-libmpdec --with-dbmliborder= py_cv_module__dbm=n/a py_cv_module__gdbm=n/a py_cv_module__tkinter=n/a && \
    make -j"$(nproc)" "EXTRA_CFLAGS=$PYCF" "LDFLAGS=$PYLD,--strip-all" && \
    rm python && make -j"$(nproc)" "EXTRA_CFLAGS=$PYCF" "LDFLAGS=$PYLD,--strip-all,-rpath='\$\$ORIGIN/../lib'" python && \
    make install COMPILEALL_OPTS=--invalidation-mode=checked-hash && \
    cd / && rm -rf /usr/src/python /usr/local/lib/python3.12/idlelib /usr/local/lib/python3.12/tkinter /usr/local/lib/python3.12/turtledemo /usr/local/bin/idle3* && \
    for s in pip3 pydoc3 python3 python3-config; do ln -sfT "$s" "/usr/local/bin/${s%3*}${s#*3}"; done && \
    ldconfig && /usr/local/bin/python3 -I -B -c "import ssl, sqlite3, zlib, bz2, lzma, ctypes, uuid, pyexpat, decimal, readline, curses, hashlib, sys, importlib.util as u; bad = [m for m in ('_dbm', '_gdbm', '_tkinter') if u.find_spec(m)]; assert not bad, ('built but must not be', bad); print(sys.version.replace(chr(10), ' '), '|', ssl.OPENSSL_VERSION, '| sqlite', sqlite3.sqlite_version, '| expat', pyexpat.EXPAT_VERSION)" && \
    ldd /usr/local/lib/python3.12/lib-dynload/_ssl.cpython-*.so | grep -qE 'libssl.so.3 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.12/lib-dynload/_sqlite3.cpython-*.so | grep -qE 'libsqlite3.so.0 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.12/lib-dynload/pyexpat.cpython-*.so | grep -qE 'libexpat.so.1 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.12/lib-dynload/_ctypes.cpython-*.so | grep -qE 'libffi.so.8 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.12/lib-dynload/_lzma.cpython-*.so | grep -qE 'liblzma.so.5 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.12/lib-dynload/_bz2.cpython-*.so | grep -qE 'libbz2.so.1.0 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.12/lib-dynload/_uuid.cpython-*.so | grep -qE 'libuuid.so.1 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.12/lib-dynload/zlib.cpython-*.so | grep -qE 'libz.so.1 => /(usr/)?lib/x86_64-linux-gnu/'
FROM cpython AS pydeps
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
COPY vendored/wheelhouse /wheelhouse
RUN pip install --no-index --no-cache-dir --no-compile --find-links=/wheelhouse -c /wheelhouse/constraints.txt -r /wheelhouse/requirements.lock --target=/deps
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289
ENV DEBIAN_FRONTEND=noninteractive PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1 PYTHONPATH=/usr/local LANG=C.UTF-8 SUPERSET_HOME=/var/lib/superset HOME=/var/lib/superset SUPERSET_CONFIG_PATH=/etc/superset/superset_config.py SUPERSET_PORT=8088 SUPERSET_ENV=production FLASK_APP="superset.app:create_app()"
COPY --from=cpython /usr/local/ /usr/local/
RUN --mount=type=bind,source=vendored/debs,target=/tmp/debs \
    set --; for f in /tmp/debs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; } && \
    ldconfig && \
    rm -rf /var/lib/apt/lists/* \
           /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /var/cache/ldconfig/aux-cache /var/cache/fontconfig
ARG SOURCE_DATE_EPOCH=1795644313
RUN groupadd -r superset && useradd -r -g superset -d /var/lib/superset -m superset && \
    mkdir -p /var/lib/superset /etc/superset && chown -R superset:superset /var/lib/superset /etc/superset && \
    : "${SOURCE_DATE_EPOCH:?SOURCE_DATE_EPOCH must be set for a reproducible build}" && \
    sed -ri "s/^([^:]*:[^:]*):[0-9]*:/\1:$((SOURCE_DATE_EPOCH/86400)):/" /etc/shadow && \
    rm -f /etc/passwd- /etc/shadow- /etc/group- /etc/gshadow-
COPY --from=pydeps /deps /usr/local
COPY superset-entrypoint.sh /usr/local/bin/superset-entrypoint.sh
COPY superset_config.py /etc/superset/superset_config.py
RUN rm -rf /usr/local/lib/python3.12/site-packages/pip /usr/local/lib/python3.12/site-packages/pip-*.dist-info /usr/local/bin/pip /usr/local/bin/pip3 /usr/local/bin/pip3.12; chown -R superset:superset /var/lib/superset /usr/local; chown superset:superset /usr/local/bin/superset-entrypoint.sh; chown superset:superset /etc/superset/superset_config.py; chmod 0755 /usr/local/bin/superset-entrypoint.sh; chmod 0644 /etc/superset/superset_config.py
LABEL org.opencontainers.image.title="Apache Superset"
LABEL org.opencontainers.image.version="6.1.0-CE-ubuntu24.04-r9"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.source="https://github.com/readystack-dev/superset"
LABEL org.opencontainers.image.description="Apache Superset, the Apache-2.0 data exploration and visualization platform"
LABEL org.opencontainers.image.vendor="ReadyStack.dev"
LABEL readystack.product="superset"
LABEL readystack.edition="CE"
LABEL readystack.build_method="source-rebuild-python"
LABEL org.opencontainers.image.revision="c83fb2bb1dcfac41ac51bcebd82471f4a7180d18"
LABEL readystack.upstream.source="https://github.com/apache/superset"
LABEL org.opencontainers.image.url="https://readystack.dev/products/superset"
LABEL org.opencontainers.image.documentation="https://github.com/readystack-dev/superset#readme"
LABEL org.opencontainers.image.authors="ReadyStack <contact@readystack.dev>"
HEALTHCHECK --interval=10s --timeout=900s --start-period=180s \
  CMD curl -fsS --max-time 10 -o /dev/null http://127.0.0.1:8088/health || exit 1
USER superset
WORKDIR /var/lib/superset
EXPOSE 8088
ENTRYPOINT ["/usr/local/bin/superset-entrypoint.sh"]
