/*  Copyright (c) Pruthvi  |  http://pruthv.com  */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderController : MonoBehaviour {

    #region Variables
    private MeshRenderer mesh;
    public Color colours;
    public float WaitSeconds = 2.0f;
    public float Amount = 1.0f;
    public bool Wait;
	#endregion

	void Start ()
	{
        mesh = GetComponent<MeshRenderer>();
        Wait = true;
	}
	
	void FixedUpdate ()
	{
        if(Wait == true)
        {
            StartCoroutine(ShaderEffect(WaitSeconds));
        }
    }

    private IEnumerator ShaderEffect(float waitTime)
    {
        Amount = 0.5f;
        mesh.material.SetFloat("_Amount", Amount);
        Wait = false;
        yield return new WaitForSeconds(waitTime);
        Amount = 0.0f;
        mesh.material.SetFloat("_Amount", Amount);
        yield return new WaitForSeconds(3);
        Wait = true;

    }

}
