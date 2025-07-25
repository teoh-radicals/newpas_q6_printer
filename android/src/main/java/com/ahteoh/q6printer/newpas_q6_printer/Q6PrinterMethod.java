package com.ahteoh.q6printer.newpas_q6_printer;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.IBinder;
import android.os.RemoteException;
import android.util.Log;
import android.widget.Toast;

import java.util.ArrayList;

import com.iposprinter.iposprinterservice.*;

import java.util.Arrays;

public class Q6PrinterMethod {
    private final String TAG = Q6PrinterMethod.class.getSimpleName();
    final Context context;
    private IPosPrinterService mIPosPrinterService;
    private IPosPrinterCallback callback = null;

    public Q6PrinterMethod(Context context) {
        this.context = context;
        callback = new IPosPrinterCallback.Stub() {
            @Override
            public void onRunResult(final boolean isSuccess) throws RemoteException {
                Log.i(TAG, "result:" + isSuccess + "\n");
            }

            @Override
            public void onReturnString(final String value) throws RemoteException {
                Log.i(TAG, "result:" + value + "\n");
            }
        };
    }

    final ServiceConnection connectService = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            Log.d(TAG, "Printer service connected");
            mIPosPrinterService = IPosPrinterService.Stub.asInterface(service);
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            Log.d(TAG, "Printer service disconnected");
            mIPosPrinterService = null;
        }
    };


    public void bindPrinterService() {
        Intent intent = new Intent();
        intent.setPackage("com.iposprinter.iposprinterservice");
        intent.setAction("com.iposprinter.iposprinterservice.IPosPrintService");
        context.bindService(intent, connectService, Context.BIND_AUTO_CREATE);
    }

    public void unbindPrinterService() {
        context.unbindService(connectService);
    }

    public void initPrinter() {
        try {
            mIPosPrinterService.printerInit(callback);
        } catch (RemoteException e) {
        } catch (NullPointerException e) {
        }
    }

    public boolean isReady() {
        return mIPosPrinterService != null;
    }

    public Boolean printText(String text) {
        try {
            mIPosPrinterService.printText(text, callback);
            performPrint();
            return true;
        } catch (RemoteException e) {
            Toast.makeText(context, "remote execption", Toast.LENGTH_LONG).show();
            return false;
        }
    }

    public Boolean setAlignment(Integer alignment) {
        try {
            mIPosPrinterService.setPrinterPrintAlignment(alignment, callback);
            return true;
        } catch (RemoteException e) {
            return false;
        } catch (NullPointerException e) {
            return false;
        }
    }

    public Boolean setFontSize(int fontSize) {
        try {
            mIPosPrinterService.setPrinterPrintFontSize(fontSize, callback);
            return true;
        } catch (RemoteException e) {
            return false;
        } catch (NullPointerException e) {
            return false;
        }
    }

    public Boolean setFontBold(Boolean bold) {
        if (bold == null) {
            bold = false;
        }

        byte[] command = new byte[]{0x1B, 0x45, 0x1};

        if (!bold) {
            command = new byte[]{0x1B, 0x45, 0x0};
        }

        try {
            mIPosPrinterService.printRawData(command, callback);
            return true;
        } catch (RemoteException e) {
            return false;
        } catch (NullPointerException e) {
            return false;
        }
    }

    public void sendRaw(byte[] bytes) {
        try {
            mIPosPrinterService.sendUserCMDData(bytes, callback);
        } catch (RemoteException e) {
        } catch (NullPointerException e) {
        }
    }

    public Boolean printColumn(String[] stringColumns, int[] columnWidth, int[] columnAlignment, int end) {
        try {
            mIPosPrinterService.printColumnsText(stringColumns, columnWidth, columnAlignment, end, callback);
            return true;
        } catch (RemoteException e) {
            return false;
        } catch (NullPointerException e) {
            return false;
        }
    }

    public void lineWrap(int lines, int height) {
        try {
            mIPosPrinterService.printBlankLines(lines, height, callback);
        } catch (RemoteException e) {
        } catch (NullPointerException e) {
        }
    }

    public void printQRCode(String data, int modulesize, int errorlevel) {
        try {
            mIPosPrinterService.printQRCode(data, modulesize, errorlevel, callback);
        } catch (RemoteException e) {
        } catch (NullPointerException e) {
        }
    }

    public void printBarCode(String data, int barcodeType, int textPosition, int width, int height) {
        try {
            mIPosPrinterService.printBarCode(data, barcodeType, height, width, textPosition, callback);
        } catch (RemoteException e) {
        } catch (NullPointerException e) {
        }
    }

    public void performPrint() {
        try {
            mIPosPrinterService.printerPerformPrint(1, callback);
        } catch (RemoteException e) {
        } catch (NullPointerException e) {
        }
    }

    public void performPrint(int feedlines) {
        try {
            mIPosPrinterService.printerPerformPrint(feedlines, callback);
        } catch (RemoteException e) {
        } catch (NullPointerException e) {
        }
    }

}