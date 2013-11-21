/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtAndroidExtras module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

package org.qtproject.example.hangman;

import org.qtproject.qt5.android.bindings.QtApplication;
import org.qtproject.qt5.android.bindings.QtActivity;
import com.android.vending.billing.*;
import android.util.Log;
import android.os.Bundle;
import android.os.IBinder;
import android.content.ServiceConnection;
import android.content.Intent;
import android.content.ComponentName;
import android.content.Context;
import android.app.PendingIntent;
import org.json.JSONObject;

public class HangmanActivity extends QtActivity
{
    private static HangmanActivity m_instance;

    private IInAppBillingService m_service;
    private ServiceConnection m_serviceConnection = new ServiceConnection() {
       @Override
       public void onServiceDisconnected(ComponentName name)
       {
           m_service = null;
       }

       @Override
       public void onServiceConnected(ComponentName name, IBinder service)
       {
           m_service = IInAppBillingService.Stub.asInterface(service);
       }
    };

    public HangmanActivity()
    {
        m_instance = this;
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        bindService(new Intent("com.android.vending.billing.InAppBillingService.BIND"),
                    m_serviceConnection, Context.BIND_AUTO_CREATE);
    }

    @Override
    public void onDestroy()
    {
        super.onDestroy();

        unbindService(m_serviceConnection);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == 1001) {
            int responseCode = data.getIntExtra("RESPONSE_CODE", -1);
            String purchaseData = data.getStringExtra("INAPP_PURCHASE_DATA");

             if (resultCode == RESULT_OK) {
                try {
                    JSONObject jo = new JSONObject(purchaseData);
                    String sku = jo.getString("productId");
                    int purchaseState = jo.getInt("purchaseState");
                    String vowel = jo.getString("developerPayload");
                    String purchaseToken = jo.getString("purchaseToken");
                    if (sku.equals("vowel") && purchaseState == 0) {
                        vowelBought(vowel.charAt(0));

                        // Make sure we can buy a vowel again
                        m_service.consumePurchase(3, getPackageName(), purchaseToken);
                        return;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
             }

             Log.e(QtApplication.QtTAG, "Buying vowel failed: Result code == " + resultCode);
        }
    }

    private static native void vowelBought(char vowel);

    public static void buyVowel(char vowel)
    {
        if (m_instance.m_service == null) {
            Log.e(QtApplication.QtTAG, "Buying vowel failed: No billing service");
            return;
        }

        try {
            Bundle buyIntentBundle = m_instance.m_service.getBuyIntent(3,
                                                                       m_instance.getPackageName(),
                                                                       "vowel",
                                                                       "inapp",
                                                                       "" + vowel);
            int responseCode = buyIntentBundle.getInt("RESPONSE_CODE");
            if (responseCode == 0) {
                PendingIntent pendingIntent = buyIntentBundle.getParcelable("BUY_INTENT");
                m_instance.startIntentSenderForResult(pendingIntent.getIntentSender(),
                                                      1001, new Intent(), Integer.valueOf(0), Integer.valueOf(0),
                                                      Integer.valueOf(0));
                return;
            } else {
                Log.e(QtApplication.QtTAG, "Buying vowel failed: Response code == " + responseCode);
            }
        } catch (Exception e) {
            Log.e(QtApplication.QtTAG, "Exception caught when buying vowel!", e);
        }
    }

}
