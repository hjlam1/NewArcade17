using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;
using System.IO.Ports;
using System.Threading;

public class SimpleSerial : MonoBehaviour {

    private SerialPort serialPort = null;
    private String portName = "COM9";  // set this to the name of your serial port, ie "/dev/tty.usbmodem1411"
    private int baudRate = 115200;  // use matching baudrate from your arduino, commonly 9600
    private int readTimeOut = 100;

    private string serialInput;

    bool programActive = true;
    Thread thread;

    void Start()
    {
        try
        {
            serialPort = new SerialPort();
            serialPort.PortName = portName;
            serialPort.BaudRate = baudRate;
            serialPort.ReadTimeout = readTimeOut;
            serialPort.Open();
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
        }
        thread = new Thread(new ThreadStart(ProcessData));  // Setting ProcessData function to be a new Thread
        thread.Start();
    }

    void ProcessData()
    {
        Debug.Log("Thread: Start");
        while (programActive)
        {
            try
            {
                serialInput = serialPort.ReadLine();  // reading in serial input
            }
            catch (TimeoutException)
            {

            }
        }
        Debug.Log("Thread: Stop");
    }

    void Update()
    {
        if (serialInput != null)  // the code below is expecting "analog, analog, digital" like "291,905,1" from arduino serial
        {
            string[] strEul = serialInput.Split(',');
            if (strEul.Length > 0)
            {
                float potA = float.Parse(strEul[0]);  
                float potB = float.Parse(strEul[1]);
                potA = (potA - 512) / 512;
                potB = (potB - 512) / 512;
                //this.transform.rotation = Quaternion.Euler(new Vector3(90.0f * potA, 90.0f * potB, 0f));  // Rotates this
                this.transform.position = new Vector3(5.0f * potA, 5.0f * potB, 0f);  // Translates this to new position
                if (int.Parse(strEul[2]) != 0)  // Condition based on arduino INPUT_PULLUP (0 for on, 1 for off)
                {
                    // do stuff when button IS NOT pushed (off)
                    this.GetComponent<MeshRenderer>().enabled = true; // turns off meshrenderer, in effect, hiding this
                }
                else
                {
                    // do stuff when button IS pushed (on)
                    this.GetComponent<MeshRenderer>().enabled = false; 
                }
            }
        }
    }

    public void OnDisable()  // closes serial port when unity runtime is closed
    {
        programActive = false;
        if (serialPort != null && serialPort.IsOpen)
            serialPort.Close();
    }
}
