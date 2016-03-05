#include <stdio.h>
#include <stdlib.h>

#include <jni.h>
#include <JNIHelp.h>
#include <ScopedUtfChars.h>

extern "C" void Java_com_brobwind_brontv_v1_NativeApplication_nSayHello(JNIEnv *env, jobject, jstring binDir)
{
	pid_t pid;
	char wrap[PATH_MAX], path[PATH_MAX];

	ScopedUtfChars _binDir(env, binDir);

	sprintf(wrap, "%s/logwrapper", _binDir.c_str());
	sprintf(path, "%s/hello-native", _binDir.c_str());

	pid = fork();
	if (pid == 0) { // Child process
		exit(execl(wrap, wrap, path, NULL));
	}
}
