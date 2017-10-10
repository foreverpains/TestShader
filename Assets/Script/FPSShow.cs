using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class FPSShow : MonoBehaviour {

    public bool isEnabled = true;

    public float updateDelay = 0.5f;

    private GUIStyle fpsStyle = new GUIStyle();
    private float accum = 0;
    private int frames = 0;
    private float timeleft;
    private string fps = "";

    public bool lockFrameRate = false;

    public int defaultFrameRate = 30;

    private void Awake()
    {
        if (lockFrameRate)
        {
            Application.targetFrameRate = defaultFrameRate;
        }
        timeleft = updateDelay;
    }

    private void Update()
    {
        if (!isEnabled) return;

        timeleft -= Time.deltaTime;
        accum += Time.timeScale / Time.deltaTime;
        ++frames;

        if (timeleft <= 0)
        {
            fps = (accum / frames).ToString("f2");
            timeleft = updateDelay;
            accum = 0;
            frames = 0;
        }
    }

    public Rect rect = new Rect(Screen.width - 150,0,140,40);
    void OnGUI()
    {
        if(GetComponent<Camera>().enabled)
        {
            GUI.Label(rect, "FPS : " + fps);
        }
        
        //GUILayout.Label("" + fps.ToString("f2"));
    }
    
}
