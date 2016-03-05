package com.brobwind.brontv.v1;

import android.app.Application;
import android.content.res.AssetManager;
import android.os.FileUtils;
import android.util.Log;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;


public class NativeApplication extends Application {
	private static final String TAG = "NativeApp";

	static {
		System.loadLibrary("native-jni");
	}

	@Override
	public void onCreate() {
		final File binDir = new File(getApplicationInfo().dataDir, "/bin");
		binDir.mkdir();
		binDir.setReadable(true, false);

		try {
			File binName = new File(binDir, "logwrapper");
//			binName.delete();
			if (binName.exists() != true) {
				AssetManager am = getAssets();
				InputStream is = am.open("bin/armeabi-v7a/" + binName.getName());
				FileUtils.copyToFile(is, binName);
				FileUtils.setPermissions(binName, FileUtils.S_IRUSR | FileUtils.S_IXUSR, -1, -1);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		try {
			File binName = new File(binDir, "hello-native");
//			binName.delete();
			if (binName.exists() != true) {
				AssetManager am = getAssets();
				InputStream is = am.open("bin/armeabi-v7a/" + binName.getName());
				FileUtils.copyToFile(is, binName);
				FileUtils.setPermissions(binName, FileUtils.S_IRUSR | FileUtils.S_IXUSR, -1, -1);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		nSayHello(binDir.getPath());
	}

	private static native void nSayHello(String binDir);
}
