//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/OilPainting" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 32573
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
int u_xlati1;
vec2 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
uint u_xlatu6;
int u_xlati8;
float u_xlat9;
int u_xlati9;
float u_xlat10;
int u_xlati12;
vec4 TempArray0[7];
vec4 TempArray1[7];
void main()
{
    TempArray0[0].x = 0.0;
    TempArray1[0].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[1].x = 0.0;
    TempArray1[1].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[2].x = 0.0;
    TempArray1[2].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[3].x = 0.0;
    TempArray1[3].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[4].x = 0.0;
    TempArray1[4].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[5].x = 0.0;
    TempArray1[5].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[6].x = 0.0;
    TempArray1[6].xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.xy = (-_MainTex_TexelSize.xy) * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
    u_xlati8 = int(0);
    u_xlati12 = int(0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<25 ; u_xlati_loop_1++)
    {
        u_xlat5.x = float(u_xlati_loop_1);
        u_xlat5.x = u_xlat5.x * 0.200000003;
        u_xlat5.x = floor(u_xlat5.x);
        u_xlati9 = int(u_xlat5.x);
        u_xlati9 = u_xlati9 * int(0xFFFFFFFBu) + u_xlati_loop_1;
        u_xlat5.y = float(u_xlati9);
        u_xlat2.xy = u_xlat5.yx * _MainTex_TexelSize.xy;
        u_xlat5.xy = u_xlat0.xy + u_xlat2.xy;
        u_xlat16_5.xyz = texture(_MainTex, u_xlat5.xy).xyz;
        u_xlat16_2 = u_xlat16_5.y + u_xlat16_5.x;
        u_xlat16_2 = u_xlat16_5.z + u_xlat16_2;
        u_xlat2.x = u_xlat16_2 * 2.33100009;
        u_xlat2.x = floor(u_xlat2.x);
        u_xlatu6 = uint(u_xlat2.x);
        u_xlat10 = TempArray0[int(u_xlatu6)].x;
        u_xlat10 = intBitsToFloat(floatBitsToInt(u_xlat10) + 1);
        TempArray0[int(u_xlatu6)].x = u_xlat10;
        u_xlat3.xyz = TempArray1[int(u_xlatu6)].xyz;
        u_xlat5.xyz = u_xlat16_5.xyz + u_xlat3.xyz;
        TempArray1[int(u_xlatu6)].xyz = u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlati8<floatBitsToInt(u_xlat10));
#else
        u_xlatb5 = u_xlati8<floatBitsToInt(u_xlat10);
#endif
        u_xlat9 = float(u_xlati12);
        u_xlat5.x = (u_xlatb5) ? u_xlat2.x : u_xlat9;
        u_xlati12 = int(u_xlat5.x);
        u_xlati8 = max(u_xlati8, floatBitsToInt(u_xlat10));
    }
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat1.xyz = TempArray1[u_xlati12].xyz;
    u_xlat4 = float(u_xlati8);
    SV_Target0.xyz = u_xlat1.xyz / vec3(u_xlat4);
    SV_Target0.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
int u_xlati1;
vec2 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
uint u_xlatu6;
int u_xlati8;
float u_xlat9;
int u_xlati9;
float u_xlat10;
int u_xlati12;
vec4 TempArray0[7];
vec4 TempArray1[7];
void main()
{
    TempArray0[0].x = 0.0;
    TempArray1[0].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[1].x = 0.0;
    TempArray1[1].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[2].x = 0.0;
    TempArray1[2].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[3].x = 0.0;
    TempArray1[3].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[4].x = 0.0;
    TempArray1[4].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[5].x = 0.0;
    TempArray1[5].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[6].x = 0.0;
    TempArray1[6].xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.xy = (-_MainTex_TexelSize.xy) * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
    u_xlati8 = int(0);
    u_xlati12 = int(0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<25 ; u_xlati_loop_1++)
    {
        u_xlat5.x = float(u_xlati_loop_1);
        u_xlat5.x = u_xlat5.x * 0.200000003;
        u_xlat5.x = floor(u_xlat5.x);
        u_xlati9 = int(u_xlat5.x);
        u_xlati9 = u_xlati9 * int(0xFFFFFFFBu) + u_xlati_loop_1;
        u_xlat5.y = float(u_xlati9);
        u_xlat2.xy = u_xlat5.yx * _MainTex_TexelSize.xy;
        u_xlat5.xy = u_xlat0.xy + u_xlat2.xy;
        u_xlat16_5.xyz = texture(_MainTex, u_xlat5.xy).xyz;
        u_xlat16_2 = u_xlat16_5.y + u_xlat16_5.x;
        u_xlat16_2 = u_xlat16_5.z + u_xlat16_2;
        u_xlat2.x = u_xlat16_2 * 2.33100009;
        u_xlat2.x = floor(u_xlat2.x);
        u_xlatu6 = uint(u_xlat2.x);
        u_xlat10 = TempArray0[int(u_xlatu6)].x;
        u_xlat10 = intBitsToFloat(floatBitsToInt(u_xlat10) + 1);
        TempArray0[int(u_xlatu6)].x = u_xlat10;
        u_xlat3.xyz = TempArray1[int(u_xlatu6)].xyz;
        u_xlat5.xyz = u_xlat16_5.xyz + u_xlat3.xyz;
        TempArray1[int(u_xlatu6)].xyz = u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlati8<floatBitsToInt(u_xlat10));
#else
        u_xlatb5 = u_xlati8<floatBitsToInt(u_xlat10);
#endif
        u_xlat9 = float(u_xlati12);
        u_xlat5.x = (u_xlatb5) ? u_xlat2.x : u_xlat9;
        u_xlati12 = int(u_xlat5.x);
        u_xlati8 = max(u_xlati8, floatBitsToInt(u_xlat10));
    }
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat1.xyz = TempArray1[u_xlati12].xyz;
    u_xlat4 = float(u_xlati8);
    SV_Target0.xyz = u_xlat1.xyz / vec3(u_xlat4);
    SV_Target0.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
int u_xlati1;
vec2 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
bool u_xlatb5;
uint u_xlatu6;
int u_xlati8;
float u_xlat9;
int u_xlati9;
float u_xlat10;
int u_xlati12;
vec4 TempArray0[7];
vec4 TempArray1[7];
void main()
{
    TempArray0[0].x = 0.0;
    TempArray1[0].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[1].x = 0.0;
    TempArray1[1].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[2].x = 0.0;
    TempArray1[2].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[3].x = 0.0;
    TempArray1[3].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[4].x = 0.0;
    TempArray1[4].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[5].x = 0.0;
    TempArray1[5].xyz = vec3(0.0, 0.0, 0.0);
    TempArray0[6].x = 0.0;
    TempArray1[6].xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.xy = (-_MainTex_TexelSize.xy) * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
    u_xlati8 = int(0);
    u_xlati12 = int(0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<25 ; u_xlati_loop_1++)
    {
        u_xlat5.x = float(u_xlati_loop_1);
        u_xlat5.x = u_xlat5.x * 0.200000003;
        u_xlat5.x = floor(u_xlat5.x);
        u_xlati9 = int(u_xlat5.x);
        u_xlati9 = u_xlati9 * int(0xFFFFFFFBu) + u_xlati_loop_1;
        u_xlat5.y = float(u_xlati9);
        u_xlat2.xy = u_xlat5.yx * _MainTex_TexelSize.xy;
        u_xlat5.xy = u_xlat0.xy + u_xlat2.xy;
        u_xlat16_5.xyz = texture(_MainTex, u_xlat5.xy).xyz;
        u_xlat16_2 = u_xlat16_5.y + u_xlat16_5.x;
        u_xlat16_2 = u_xlat16_5.z + u_xlat16_2;
        u_xlat2.x = u_xlat16_2 * 2.33100009;
        u_xlat2.x = floor(u_xlat2.x);
        u_xlatu6 = uint(u_xlat2.x);
        u_xlat10 = TempArray0[int(u_xlatu6)].x;
        u_xlat10 = intBitsToFloat(floatBitsToInt(u_xlat10) + 1);
        TempArray0[int(u_xlatu6)].x = u_xlat10;
        u_xlat3.xyz = TempArray1[int(u_xlatu6)].xyz;
        u_xlat5.xyz = u_xlat16_5.xyz + u_xlat3.xyz;
        TempArray1[int(u_xlatu6)].xyz = u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlati8<floatBitsToInt(u_xlat10));
#else
        u_xlatb5 = u_xlati8<floatBitsToInt(u_xlat10);
#endif
        u_xlat9 = float(u_xlati12);
        u_xlat5.x = (u_xlatb5) ? u_xlat2.x : u_xlat9;
        u_xlati12 = int(u_xlat5.x);
        u_xlati8 = max(u_xlati8, floatBitsToInt(u_xlat10));
    }
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat1.xyz = TempArray1[u_xlati12].xyz;
    u_xlat4 = float(u_xlati8);
    SV_Target0.xyz = u_xlat1.xyz / vec3(u_xlat4);
    SV_Target0.w = u_xlat16_0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
}
}