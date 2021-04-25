# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
#-------------------------------------------基本不用动区域----------------------------------------
#忽略警告 不忽略可能打包不成功
-ignorewarnings
#---------------------------------基本指令区----------------------------------
-optimizationpasses 5
-dontskipnonpubliclibraryclassmembers
-printmapping proguardMapping.txt
-optimizations !code/simplification/cast,!field/*,!class/merging/*
-keepattributes *Annotation*,InnerClasses
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
#----------------------------------------------------------------------------

#---------------------------------默认保留区---------------------------------
-ignorewarnings
# 保留我们使用的四大组件，自定义的Application等等这些类不被混淆
# 因为这些子类都有可能被外部调用
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Appliction
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.view.View
-keep public class com.android.vending.licensing.ILicensingService
# 保留support下的所有类及其内部类
-keep class android.support.** {*;}

# 保留继承的
-keep public class * extends android.support.v4.**
-keep public class * extends android.support.v7.**
-keep public class * extends android.support.annotation.**

#androidx包使用混淆
-keep class com.google.android.material.** {*;}
-keep class androidx.** {*;}
-keep public class * extends androidx.**
-keep interface androidx.** {*;}
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**
-dontwarn androidx.**

# 保留R下面的资源
-keep class **.R$* {*;}

# 保留本地native方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}

# 保留在Activity中的方法参数是view的方法，
# 这样以来我们在layout中写的onClick就不会被影响
-keepclassmembers class * extends android.app.Activity{
    public void *(android.view.View);
}

# 保留枚举类不被混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# 保留我们自定义控件（继承自View）不被混淆
-keep public class * extends android.view.View{
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

# 保留Parcelable序列化类不被混淆
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# 保留Serializable序列化的类不被混淆
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    !private <fields>;
    !private <methods>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# 对于带有回调函数的onXXEvent、**On*Listener的，不能被混淆
-keepclassmembers class * {
    void *(**On*Event);
    void *(**On*Listener);
}

#----------------------------------------------------------------------------
#---------------------------------webview (项目中没有使用到webView忽略即可)-----------------------------------
-keepclassmembers class fqcn.of.javascript.interface.for.Webview {
   public *;
}
-keepclassmembers class * extends android.webkit.WebViewClient {
    public void *(android.webkit.WebView, java.lang.String, android.graphics.Bitmap);
    public boolean *(android.webkit.WebView, java.lang.String);
}
-keepclassmembers class * extends android.webkit.WebViewClient {
    public void *(android.webkit.WebView, jav.lang.String);
}
#----------------------------------------------------------------------------------------------------------

#-------------------------------------------定制化区域----------------------------------------------
#---------------------------------1.实体类---------------------------------
#bean的包路径（如下：）


#-------------------------------------------------------------------------

#---------------------------------2.第三方包-------------------------------
#一些依赖库的混淆（如：gson）
##---------------Begin: proguard configuration for Gson  ----------
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

# Gson specific classes
-dontwarn sun.misc.**
#-keep class com.google.gson.stream.** { *; }

# Application classes that will be serialized/deserialized over Gson
-keep class com.google.gson.examples.android.model.** { <fields>; }

# Prevent proguard from stripping interface information from TypeAdapter, TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * implements com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Prevent R8 from leaving Data object members always null
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}
##---------------End: proguard configuration for Gson  ----------
#-------------------------------------------------------------------------

#---------------------------------3.与js互相调用的类(如果没有可忽略)------------------------

#-keep class 你的类所在的包.** { *; }
#如果是内部类的话
#-keepclasseswithmembers class 你的类所在的包.父类$子类 { <methods>; }如下：
-keepclasseswithmembers class net.hyntech.**$JSInterface {
      <methods>;
}

#-------------------------------------------------------------------------

#---------------------------------4.反射相关的类和方法(如果没有可忽略)-----------------------
#-keep class 你的类所在的包.** { *; }

#----------------------------------------------------------------------------


-keep class com.google.android.material.** {*;}
-keep class androidx.** {*;}
-keep public class * extends androidx.**
-keep interface androidx.** {*;}
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**
-dontwarn androidx.**

-keep class net.hyntech.**.app.** { *; }
-keep class net.hyntech.**.base.** { *; }
-keep class net.hyntech.**.db.** { *; }
-keep class net.hyntech.**.ext.** { *; }
-keep class net.hyntech.**.http.** { *; }
-keep class net.hyntech.**.provider.** { *; }
-keep class net.hyntech.**.utils.** { *; }
-keep class net.hyntech.**.widget.** { *; }
-keep class net.hyntech.**.entity.** { *; }


-dontwarn com.xuexiang.xupdate.**
-keep class com.xuexiang.xupdate.**{*;}

-dontwarn com.blankj.utilcode.**
-keep class com.blankj.utilcode.**{*;}

-dontwarn com.tbruyelle.rxpermissions2.**
-keep class com.tbruyelle.rxpermissions2.**{*;}

-dontwarn com.irozon.sneaker.**
-keep class com.irozon.sneaker.**{*;}

-dontwarn com.zhy.http.okhttp.**
-keep class com.zhy.http.okhttp.**{*;}

-dontwarn io.socket.**
-keep class io.socket.**{*;}

-dontwarn me.jessyan.autosize.**
-keep class me.jessyan.autosize.**{*;}

-dontwarn com.github.salomonbrys.kotson.**
-keep class com.github.salomonbrys.kotson.**{*;}

-dontwarn org.apache.commons.**
-keep class org.apache.commons.**{*;}

-dontwarn com.franmontiel.persistentcookiejar.**
-keep class com.franmontiel.persistentcookiejar.**{*;}

-dontwarn razerdp.widget.**
-keep class razerdp.widget.**{*;}

-dontwarn com.github.chrisbanes.photoview.**
-keep class com.github.chrisbanes.photoview.**{*;}
#org.conscrypt
-dontwarn org.conscrypt.**
-keep class org.conscrypt.** { *; }
-keep interface org.conscrypt.** { *; }



#banner
-keep class androidx.viewpager2.widget.ViewPager2{
androidx.viewpager2.widget.PageTransformerAdapter mPageTransformerAdapter;
androidx.viewpager2.widget.ScrollEventAdapter mScrollEventAdapter;
}

-keep class androidx.viewpager2.widget.PageTransformerAdapter{
androidx.recyclerview.widget.LinearLayoutManager mLayoutManager;
}

-keep class androidx.recyclerview.widget.RecyclerView$LayoutManager{
androidx.recyclerview.widget.RecyclerView mRecyclerView;
}

-keep class androidx.viewpager2.widget.ScrollEventAdapter{
androidx.recyclerview.widget.LinearLayoutManager mLayoutManager;
}

-dontwarn com.scwang.smart.**
-keep class com.scwang.smart.**{*;}

-keep public class com.scwang.smart.refresh.classics.* {*;}

-keep public class com.alibaba.android.arouter.routes.**{*;}
-keep public class com.alibaba.android.arouter.facade.**{*;}
-keep class * implements com.alibaba.android.arouter.facade.template.ISyringe{*;}

# If you use the byType method to obtain Service, add the following rules to protect the interface:
-keep interface * implements com.alibaba.android.arouter.facade.template.IProvider

# If single-type injection is used, that is, no interface is defined to implement IProvider, the following rules need to be added to protect the implementation
# -keep class * implements com.alibaba.android.arouter.facade.template.IProvider

-keep public class * implements com.bumptech.glide.module.GlideModule
-keep class * extends com.bumptech.glide.module.AppGlideModule {
 <init>(...);
}
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}
-keep class com.bumptech.glide.load.data.ParcelFileDescriptorRewinder$InternalRewinder {
  *** rewind();
}
-dontwarn dalvik.**
-dontwarn com.tencent.smtt.**

-keep class com.tencent.smtt.** {
    *;
}

-keep class com.tencent.tbs.** {
    *;
}
# for DexGuard only
#-keepresourcexmlelements manifest/application/meta-data@value=GlideModule

#百度地图混淆
-keep class com.baidu.** {*;}
-keep class vi.com.** {*;}
-dontwarn com.baidu.**
#百度地图混淆-end

-dontwarn com.meituan.android.walle.**
-keep class com.meituan.android.walle.**{*;}

-dontwarn org.greenrobot.eventbus.**
-keep class org.greenrobot.eventbus.**{*;}

-keepattributes *Annotation*
-keepclassmembers class * {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode { *; }

# And if you use AsyncExecutor:
-keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}
#PictureSelector 2.0
-keep class com.luck.picture.lib.** { *; }

#Ucrop
-dontwarn com.yalantis.ucrop**
-keep class com.yalantis.ucrop** { *; }
-keep interface com.yalantis.ucrop** { *; }

#Okio
-dontwarn org.codehaus.mojo.animal_sniffer.*
-keepnames class androidx.navigation.fragment.NavHostFragment

-dontwarn com.bigkoo.pickerview.**
-keep class com.bigkoo.pickerview.**{*;}
-dontoptimize
-dontpreverify

-dontwarn cn.jpush.**
-keep class cn.jpush.** { *; }
-keep class * extends cn.jpush.android.helpers.JPushMessageReceiver { *; }

-dontwarn cn.jiguang.**
-keep class cn.jiguang.** { *; }
-keep class com.xuexiang.xupdate.entity.** { *; }
#okhttputils
-dontwarn com.zhy.http.**
-keep class com.zhy.http.**{*;}
#okhttp
-dontwarn okhttp3.**
-keep class okhttp3.**{*;}
#okio
-dontwarn okio.**
-keep class okio.**{*;}
#支付宝混淆
-keep class com.alipay.android.app.IAlixPay{*;}
-keep class com.alipay.android.app.IAlixPay$Stub{*;}
-keep class com.alipay.android.app.IRemoteServiceCallback{*;}
-keep class com.alipay.android.app.IRemoteServiceCallback$Stub{*;}
-keep class com.alipay.sdk.app.PayTask{ public *;}
-keep class com.alipay.sdk.app.AuthTask{ public *;}
-keep class com.alipay.sdk.app.H5PayCallback {
    <fields>;
    <methods>;
}
-dontwarn com.alipay.android.phone.mrpc.core.**
-keep class com.alipay.android.phone.mrpc.core.** { *; }
-keep class com.alipay.apmobilesecuritysdk.** { *; }
-keep class com.alipay.mobile.framework.service.annotation.** { *; }
-keep class com.alipay.mobilesecuritysdk.face.** { *; }
-keep class com.alipay.tscenter.biz.rpc.** { *; }
-keep class org.json.alipay.** { *; }
-keep class com.alipay.tscenter.** { *; }
-keep class com.ta.utdid2.** { *;}
-keep class com.ut.device.** { *;}

# AVLoading
-keep class com.wang.avi.** { *; }
-keep class com.wang.avi.indicators.** { *; }

# 多状态布局
-dontwarn com.zy.multistatepage.**
-keep class com.zy.multistatepage.**{*;}

# 状态栏
-keep class com.zackratos.ultimatebarx.ultimatebarx.** { *; }
-keep public class * extends androidx.fragment.app.Fragment { *; }

# 百度ocr
-keep class com.baidu.ocr.sdk.**{*;}
-dontwarn com.baidu.ocr.**

#ZXing
-dontwarn com.google.zxing.**
-keep class com.google.zxing.**{ *;}

-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
-keep class com.hianalytics.android.**{*;}
-keep class com.huawei.**{*;}


