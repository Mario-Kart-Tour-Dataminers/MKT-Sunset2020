//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/ScalableAO" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 5866
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * _ZBufferParams.x;
    u_xlat27 = (-unity_OrthoParams.w) * u_xlat18.x + 1.0;
    u_xlat9 = u_xlat9 * u_xlat18.x + _ZBufferParams.y;
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = u_xlat9 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat9 = u_xlat9 * _FogParams.x;
    u_xlat9 = u_xlat9 * (-u_xlat9);
    u_xlat9 = exp2(u_xlat9);
    SV_Target0.x = u_xlat9 * u_xlat0.x;
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * _ZBufferParams.x;
    u_xlat27 = (-unity_OrthoParams.w) * u_xlat18.x + 1.0;
    u_xlat9 = u_xlat9 * u_xlat18.x + _ZBufferParams.y;
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = u_xlat9 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat9 = u_xlat9 * _FogParams.x;
    u_xlat9 = u_xlat9 * (-u_xlat9);
    u_xlat9 = exp2(u_xlat9);
    SV_Target0.x = u_xlat9 * u_xlat0.x;
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * _ZBufferParams.x;
    u_xlat27 = (-unity_OrthoParams.w) * u_xlat18.x + 1.0;
    u_xlat9 = u_xlat9 * u_xlat18.x + _ZBufferParams.y;
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = u_xlat9 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat9 = u_xlat9 * _FogParams.x;
    u_xlat9 = u_xlat9 * (-u_xlat9);
    u_xlat9 = exp2(u_xlat9);
    SV_Target0.x = u_xlat9 * u_xlat0.x;
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * _ZBufferParams.x;
    u_xlat27 = (-unity_OrthoParams.w) * u_xlat18.x + 1.0;
    u_xlat9 = u_xlat9 * u_xlat18.x + _ZBufferParams.y;
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = u_xlat9 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat9 = (-u_xlat9) + _FogParams.z;
    u_xlat18.x = (-_FogParams.y) + _FogParams.z;
    u_xlat9 = u_xlat9 / u_xlat18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.x = u_xlat9 * u_xlat0.x;
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * _ZBufferParams.x;
    u_xlat27 = (-unity_OrthoParams.w) * u_xlat18.x + 1.0;
    u_xlat9 = u_xlat9 * u_xlat18.x + _ZBufferParams.y;
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = u_xlat9 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat9 = (-u_xlat9) + _FogParams.z;
    u_xlat18.x = (-_FogParams.y) + _FogParams.z;
    u_xlat9 = u_xlat9 / u_xlat18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.x = u_xlat9 * u_xlat0.x;
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraDepthNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat14;
int u_xlati14;
bvec2 u_xlatb14;
vec2 u_xlat18;
mediump float u_xlat16_18;
ivec2 u_xlati18;
bvec2 u_xlatb18;
vec2 u_xlat22;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
int u_xlati30;
bool u_xlatb30;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = 2.0 / u_xlat16_18;
    u_xlat10.xy = u_xlat16_1.xy * vec2(u_xlat16_18);
    u_xlat10.z = u_xlat16_18 + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * vec3(1.0, 1.0, -1.0);
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat9 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat18.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat9 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati18.x = int(uint((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu)));
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati18.y = int(uint((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu)));
    u_xlati18.xy = ivec2(uvec2(uint(u_xlati18.x) & uint(1u), uint(u_xlati18.y) & uint(1u)));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = u_xlat0.x * _ProjectionParams.z + u_xlat18.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = unity_OrthoParams.w * u_xlat27 + u_xlat3.z;
    u_xlat3.xy = vec2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat18.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * _ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat29 = float(u_xlati_loop_1);
        u_xlat5.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat29;
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = u_xlat30 * 2.0 + -1.0;
        u_xlat30 = dot(u_xlat5.xy, vec2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = (-u_xlat6.z) * u_xlat6.z + 1.0;
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = vec2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / _AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * _AOParams.y;
        u_xlat14.xyz = vec3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb29 = !!(u_xlat29>=0.0);
#else
        u_xlatb29 = u_xlat29>=0.0;
#endif
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat14.xx + u_xlat22.xy;
        u_xlat22.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat14.zz + u_xlat22.xy;
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat14.z;
        u_xlat22.xy = u_xlat22.xy / vec2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + vec2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
        u_xlat14.xy = u_xlat14.xy * vec2(_RenderViewportScaleFactor);
        u_xlat29 = textureLod(_CameraDepthTexture, u_xlat14.xy, 0.0).x;
        u_xlat29 = u_xlat29 * _ZBufferParams.x;
        u_xlat30 = (-unity_OrthoParams.w) * u_xlat29 + 1.0;
        u_xlat29 = u_xlat9 * u_xlat29 + _ZBufferParams.y;
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = lessThan(u_xlat22.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 1 : int(0);
        u_xlatb14.xy = lessThan(vec4(2.0, 2.0, 0.0, 0.0), u_xlat22.xyxx).xy;
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
#ifdef UNITY_ADRENO_ES3
        u_xlatb14.x = !!(9.99999975e-06>=u_xlat29);
#else
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
#endif
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = u_xlat29 * _ProjectionParams.z + u_xlat30;
        u_xlat22.xy = u_xlat22.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + vec2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = unity_OrthoParams.w * u_xlat29 + u_xlat6.z;
        u_xlat6.xy = vec2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = (-u_xlat3.z) * 0.00200000009 + u_xlat29;
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
    }
    u_xlat0.x = u_xlat27 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * _ZBufferParams.x;
    u_xlat27 = (-unity_OrthoParams.w) * u_xlat18.x + 1.0;
    u_xlat9 = u_xlat9 * u_xlat18.x + _ZBufferParams.y;
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = u_xlat9 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat9 = (-u_xlat9) + _FogParams.z;
    u_xlat18.x = (-_FogParams.y) + _FogParams.z;
    u_xlat9 = u_xlat9 / u_xlat18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.x = u_xlat9 * u_xlat0.x;
    SV_Target0.yzw = u_xlat10.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
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
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_FORWARD_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_FORWARD_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_FORWARD_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
""
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 123419
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    SV_Target0.x = exp2(u_xlat0.x);
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * _ZBufferParams.x;
    u_xlat24 = (-unity_OrthoParams.w) * u_xlat16.x + 1.0;
    u_xlat8 = u_xlat8 * u_xlat16.x + _ZBufferParams.y;
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = u_xlat8 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 * _FogParams.x;
    u_xlat8 = u_xlat8 * (-u_xlat8);
    u_xlat8 = exp2(u_xlat8);
    SV_Target0.x = u_xlat8 * u_xlat0.x;
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * _ZBufferParams.x;
    u_xlat24 = (-unity_OrthoParams.w) * u_xlat16.x + 1.0;
    u_xlat8 = u_xlat8 * u_xlat16.x + _ZBufferParams.y;
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = u_xlat8 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 * _FogParams.x;
    u_xlat8 = u_xlat8 * (-u_xlat8);
    u_xlat8 = exp2(u_xlat8);
    SV_Target0.x = u_xlat8 * u_xlat0.x;
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * _ZBufferParams.x;
    u_xlat24 = (-unity_OrthoParams.w) * u_xlat16.x + 1.0;
    u_xlat8 = u_xlat8 * u_xlat16.x + _ZBufferParams.y;
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = u_xlat8 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 * _FogParams.x;
    u_xlat8 = u_xlat8 * (-u_xlat8);
    u_xlat8 = exp2(u_xlat8);
    SV_Target0.x = u_xlat8 * u_xlat0.x;
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * _ZBufferParams.x;
    u_xlat24 = (-unity_OrthoParams.w) * u_xlat16.x + 1.0;
    u_xlat8 = u_xlat8 * u_xlat16.x + _ZBufferParams.y;
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = u_xlat8 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat8 = (-u_xlat8) + _FogParams.z;
    u_xlat16.x = (-_FogParams.y) + _FogParams.z;
    u_xlat8 = u_xlat8 / u_xlat16.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    SV_Target0.x = u_xlat8 * u_xlat0.x;
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * _ZBufferParams.x;
    u_xlat24 = (-unity_OrthoParams.w) * u_xlat16.x + 1.0;
    u_xlat8 = u_xlat8 * u_xlat16.x + _ZBufferParams.y;
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = u_xlat8 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat8 = (-u_xlat8) + _FogParams.z;
    u_xlat16.x = (-_FogParams.y) + _FogParams.z;
    u_xlat8 = u_xlat8 / u_xlat16.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    SV_Target0.x = u_xlat8 * u_xlat0.x;
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec3 _FogParams;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _CameraGBufferTexture2;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
vec2 u_xlat7;
float u_xlat8;
vec3 u_xlat12;
ivec2 u_xlati12;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb16;
vec2 u_xlat19;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat24;
bool u_xlatb24;
int u_xlati25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xyz = texture(_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16.x = !!(u_xlat16.x!=0.0);
#else
    u_xlatb16.x = u_xlat16.x!=0.0;
#endif
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat0.x = textureLod(_CameraDepthTexture, u_xlat0.xy, 0.0).x;
    u_xlat8 = (-unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat16.x = (-unity_OrthoParams.w) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = lessThan(vs_TEXCOORD0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlati16.x = int(uint((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu)));
    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), vs_TEXCOORD0.xyxx).xy;
    u_xlati16.y = int(uint((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu)));
    u_xlati16.xy = ivec2(uvec2(uint(u_xlati16.x) & uint(1u), uint(u_xlati16.y) & uint(1u)));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(9.99999975e-06>=u_xlat0.x);
#else
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
#endif
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = u_xlat0.x * _ProjectionParams.z + u_xlat16.x;
    u_xlat0.xz = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xz = u_xlat0.xz + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = unity_OrthoParams.w * u_xlat24 + u_xlat2.z;
    u_xlat2.xy = vec2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(_AOParams.w);
    u_xlat16.xy = vs_TEXCOORD0.xy * _AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * _ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(vec2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<u_xlati0 ; u_xlati_loop_1++)
    {
        u_xlat26 = float(u_xlati_loop_1);
        u_xlat4.y = vs_TEXCOORD0.x * 1.00000001e-10 + u_xlat26;
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = u_xlat19.x * 2.0 + -1.0;
        u_xlat19.x = dot(u_xlat4.xy, vec2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = (-u_xlat5.z) * u_xlat5.z + 1.0;
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / _AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * _AOParams.y;
        u_xlat12.xyz = vec3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
        u_xlatb26 = !!(u_xlat26>=0.0);
#else
        u_xlatb26 = u_xlat26>=0.0;
#endif
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[0].xy * u_xlat12.xx + u_xlat19.xy;
        u_xlat19.xy = hlslcc_mtx4x4unity_CameraProjection[2].xy * u_xlat12.zz + u_xlat19.xy;
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat12.z;
        u_xlat19.xy = u_xlat19.xy / vec2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
        u_xlat12.xy = u_xlat12.xy * vec2(_RenderViewportScaleFactor);
        u_xlat26 = textureLod(_CameraDepthTexture, u_xlat12.xy, 0.0).x;
        u_xlat26 = u_xlat26 * _ZBufferParams.x;
        u_xlat12.x = (-unity_OrthoParams.w) * u_xlat26 + 1.0;
        u_xlat26 = u_xlat8 * u_xlat26 + _ZBufferParams.y;
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = lessThan(u_xlat19.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
        u_xlati12.x = int(uint((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu)));
        u_xlatb20.xy = lessThan(vec4(2.0, 2.0, 2.0, 2.0), u_xlat19.xyxy).xy;
        u_xlati12.y = int(uint((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu)));
        u_xlati12.xy = ivec2(uvec2(uint(u_xlati12.x) & uint(1u), uint(u_xlati12.y) & uint(1u)));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(9.99999975e-06>=u_xlat26);
#else
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
#endif
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = u_xlat26 * _ProjectionParams.z + u_xlat12.x;
        u_xlat19.xy = u_xlat19.xy + (-hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + vec2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = unity_OrthoParams.w * u_xlat26 + u_xlat5.z;
        u_xlat5.xy = vec2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = (-u_xlat2.z) * 0.00200000009 + u_xlat26;
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
    }
    u_xlat0.x = u_xlat24 * _AOParams.y;
    u_xlat0.x = u_xlat0.x * _AOParams.x;
    u_xlat0.x = u_xlat0.x / _AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * _ZBufferParams.x;
    u_xlat24 = (-unity_OrthoParams.w) * u_xlat16.x + 1.0;
    u_xlat8 = u_xlat8 * u_xlat16.x + _ZBufferParams.y;
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = u_xlat8 * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat8 = (-u_xlat8) + _FogParams.z;
    u_xlat16.x = (-_FogParams.y) + _FogParams.z;
    u_xlat8 = u_xlat8 / u_xlat16.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    SV_Target0.x = u_xlat8 * u_xlat0.x;
    SV_Target0.yzw = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
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
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_FORWARD_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_FORWARD_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_FORWARD_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
""
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 142120
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CameraDepthNormalsTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_7;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
float u_xlat10;
float u_xlat11;
float u_xlat12;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
float u_xlat17;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.x;
    u_xlat0.y = 0.0;
    u_xlat1 = (-u_xlat0.xyxy) * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0.xyxy * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_13 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_13 = 2.0 / u_xlat16_13;
    u_xlat9.xy = u_xlat16_3.xy * vec2(u_xlat16_13);
    u_xlat9.z = u_xlat16_13 + -1.0;
    u_xlat3.xyz = u_xlat9.xyz * vec3(1.0, 1.0, -1.0);
    SV_Target0.yzw = u_xlat9.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat7 = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat7 * -2.0 + 3.0;
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat7 = u_xlat7 * 0.31621623;
    u_xlat2 = u_xlat7 * u_xlat16_2.x;
    u_xlat16_12 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat2 = u_xlat16_12 * 0.227027029 + u_xlat2;
    u_xlat16_4 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat16_9.xyz);
    u_xlat12 = u_xlat12 + -0.800000012;
    u_xlat12 = u_xlat12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat17;
    u_xlat17 = u_xlat12 * 0.31621623;
    u_xlat7 = u_xlat12 * 0.31621623 + u_xlat7;
    u_xlat2 = u_xlat16_4.x * u_xlat17 + u_xlat2;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat6 = u_xlat6 + -0.800000012;
    u_xlat6 = u_xlat6 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat11;
    u_xlat11 = u_xlat6 * 0.0702702701;
    u_xlat6 = u_xlat6 * 0.0702702701 + u_xlat7;
    u_xlat1.x = u_xlat16_1.x * u_xlat11 + u_xlat2;
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat5 = u_xlat5 + -0.800000012;
    u_xlat5 = u_xlat5 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = u_xlat5 * 0.0702702701;
    u_xlat5 = u_xlat5 * 0.0702702701 + u_xlat6;
    u_xlat5 = u_xlat5 + 0.227027029;
    u_xlat0.x = u_xlat16_0.x * u_xlat10 + u_xlat1.x;
    SV_Target0.x = u_xlat0.x / u_xlat5;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CameraDepthNormalsTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_7;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
float u_xlat10;
float u_xlat11;
float u_xlat12;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
float u_xlat17;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.x;
    u_xlat0.y = 0.0;
    u_xlat1 = (-u_xlat0.xyxy) * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0.xyxy * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_13 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_13 = 2.0 / u_xlat16_13;
    u_xlat9.xy = u_xlat16_3.xy * vec2(u_xlat16_13);
    u_xlat9.z = u_xlat16_13 + -1.0;
    u_xlat3.xyz = u_xlat9.xyz * vec3(1.0, 1.0, -1.0);
    SV_Target0.yzw = u_xlat9.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat7 = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat7 * -2.0 + 3.0;
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat7 = u_xlat7 * 0.31621623;
    u_xlat2 = u_xlat7 * u_xlat16_2.x;
    u_xlat16_12 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat2 = u_xlat16_12 * 0.227027029 + u_xlat2;
    u_xlat16_4 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat16_9.xyz);
    u_xlat12 = u_xlat12 + -0.800000012;
    u_xlat12 = u_xlat12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat17;
    u_xlat17 = u_xlat12 * 0.31621623;
    u_xlat7 = u_xlat12 * 0.31621623 + u_xlat7;
    u_xlat2 = u_xlat16_4.x * u_xlat17 + u_xlat2;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat6 = u_xlat6 + -0.800000012;
    u_xlat6 = u_xlat6 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat11;
    u_xlat11 = u_xlat6 * 0.0702702701;
    u_xlat6 = u_xlat6 * 0.0702702701 + u_xlat7;
    u_xlat1.x = u_xlat16_1.x * u_xlat11 + u_xlat2;
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat5 = u_xlat5 + -0.800000012;
    u_xlat5 = u_xlat5 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = u_xlat5 * 0.0702702701;
    u_xlat5 = u_xlat5 * 0.0702702701 + u_xlat6;
    u_xlat5 = u_xlat5 + 0.227027029;
    u_xlat0.x = u_xlat16_0.x * u_xlat10 + u_xlat1.x;
    SV_Target0.x = u_xlat0.x / u_xlat5;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CameraDepthNormalsTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_7;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
float u_xlat10;
float u_xlat11;
float u_xlat12;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
float u_xlat17;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.x;
    u_xlat0.y = 0.0;
    u_xlat1 = (-u_xlat0.xyxy) * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0.xyxy * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_13 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_13 = 2.0 / u_xlat16_13;
    u_xlat9.xy = u_xlat16_3.xy * vec2(u_xlat16_13);
    u_xlat9.z = u_xlat16_13 + -1.0;
    u_xlat3.xyz = u_xlat9.xyz * vec3(1.0, 1.0, -1.0);
    SV_Target0.yzw = u_xlat9.xyz * vec3(0.5, 0.5, -0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat7 = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat7 * -2.0 + 3.0;
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat7 = u_xlat7 * 0.31621623;
    u_xlat2 = u_xlat7 * u_xlat16_2.x;
    u_xlat16_12 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat2 = u_xlat16_12 * 0.227027029 + u_xlat2;
    u_xlat16_4 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat16_9.xyz);
    u_xlat12 = u_xlat12 + -0.800000012;
    u_xlat12 = u_xlat12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat17;
    u_xlat17 = u_xlat12 * 0.31621623;
    u_xlat7 = u_xlat12 * 0.31621623 + u_xlat7;
    u_xlat2 = u_xlat16_4.x * u_xlat17 + u_xlat2;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat6 = u_xlat6 + -0.800000012;
    u_xlat6 = u_xlat6 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat11;
    u_xlat11 = u_xlat6 * 0.0702702701;
    u_xlat6 = u_xlat6 * 0.0702702701 + u_xlat7;
    u_xlat1.x = u_xlat16_1.x * u_xlat11 + u_xlat2;
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
    u_xlat5 = u_xlat5 + -0.800000012;
    u_xlat5 = u_xlat5 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = u_xlat5 * 0.0702702701;
    u_xlat5 = u_xlat5 * 0.0702702701 + u_xlat6;
    u_xlat5 = u_xlat5 + 0.227027029;
    u_xlat0.x = u_xlat16_0.x * u_xlat10 + u_xlat1.x;
    SV_Target0.x = u_xlat0.x / u_xlat5;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 229203
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CameraGBufferTexture2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
float u_xlat6;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_8;
float u_xlat12;
float u_xlat13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat16_0.xyz = texture(_CameraGBufferTexture2, vs_TEXCOORD1.xy).xyz;
    u_xlat15 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15!=0.0);
#else
    u_xlatb15 = u_xlat15!=0.0;
#endif
    u_xlat15 = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(u_xlat15);
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat1.x = _MainTex_TexelSize.x;
    u_xlat1.y = 0.0;
    u_xlat2 = (-u_xlat1.xyxy) * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1.xyxy * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_8.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat15 = u_xlat15 + -0.800000012;
    u_xlat15 = u_xlat15 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8;
    u_xlat15 = u_xlat15 * 0.31621623;
    u_xlat3 = u_xlat15 * u_xlat16_3.x;
    u_xlat16_8.x = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat3 = u_xlat16_8.x * 0.227027029 + u_xlat3;
    u_xlat16_4 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_8.xyz = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat8 = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat8 = u_xlat8 + -0.800000012;
    u_xlat8 = u_xlat8 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat13;
    u_xlat13 = u_xlat8 * 0.31621623;
    u_xlat15 = u_xlat8 * 0.31621623 + u_xlat15;
    u_xlat3 = u_xlat16_4.x * u_xlat13 + u_xlat3;
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat7 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat7 * -2.0 + 3.0;
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * 0.0702702701;
    u_xlat15 = u_xlat7 * 0.0702702701 + u_xlat15;
    u_xlat2.x = u_xlat16_2.x * u_xlat12 + u_xlat3;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat16_6.xyz);
    SV_Target0.yzw = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.x = u_xlat6 + -0.800000012;
    u_xlat0.x = u_xlat0.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat5 = u_xlat0.x * 0.0702702701;
    u_xlat0.x = u_xlat0.x * 0.0702702701 + u_xlat15;
    u_xlat0.x = u_xlat0.x + 0.227027029;
    u_xlat5 = u_xlat16_1.x * u_xlat5 + u_xlat2.x;
    SV_Target0.x = u_xlat5 / u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CameraGBufferTexture2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
float u_xlat6;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_8;
float u_xlat12;
float u_xlat13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat16_0.xyz = texture(_CameraGBufferTexture2, vs_TEXCOORD1.xy).xyz;
    u_xlat15 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15!=0.0);
#else
    u_xlatb15 = u_xlat15!=0.0;
#endif
    u_xlat15 = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(u_xlat15);
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat1.x = _MainTex_TexelSize.x;
    u_xlat1.y = 0.0;
    u_xlat2 = (-u_xlat1.xyxy) * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1.xyxy * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_8.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat15 = u_xlat15 + -0.800000012;
    u_xlat15 = u_xlat15 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8;
    u_xlat15 = u_xlat15 * 0.31621623;
    u_xlat3 = u_xlat15 * u_xlat16_3.x;
    u_xlat16_8.x = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat3 = u_xlat16_8.x * 0.227027029 + u_xlat3;
    u_xlat16_4 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_8.xyz = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat8 = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat8 = u_xlat8 + -0.800000012;
    u_xlat8 = u_xlat8 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat13;
    u_xlat13 = u_xlat8 * 0.31621623;
    u_xlat15 = u_xlat8 * 0.31621623 + u_xlat15;
    u_xlat3 = u_xlat16_4.x * u_xlat13 + u_xlat3;
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat7 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat7 * -2.0 + 3.0;
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * 0.0702702701;
    u_xlat15 = u_xlat7 * 0.0702702701 + u_xlat15;
    u_xlat2.x = u_xlat16_2.x * u_xlat12 + u_xlat3;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat16_6.xyz);
    SV_Target0.yzw = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.x = u_xlat6 + -0.800000012;
    u_xlat0.x = u_xlat0.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat5 = u_xlat0.x * 0.0702702701;
    u_xlat0.x = u_xlat0.x * 0.0702702701 + u_xlat15;
    u_xlat0.x = u_xlat0.x + 0.227027029;
    u_xlat5 = u_xlat16_1.x * u_xlat5 + u_xlat2.x;
    SV_Target0.x = u_xlat5 / u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CameraGBufferTexture2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
float u_xlat6;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_8;
float u_xlat12;
float u_xlat13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat16_0.xyz = texture(_CameraGBufferTexture2, vs_TEXCOORD1.xy).xyz;
    u_xlat15 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15!=0.0);
#else
    u_xlatb15 = u_xlat15!=0.0;
#endif
    u_xlat15 = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(u_xlat15);
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat1.x = _MainTex_TexelSize.x;
    u_xlat1.y = 0.0;
    u_xlat2 = (-u_xlat1.xyxy) * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1.xyxy * vec4(2.76923084, 1.38461542, 6.46153831, 3.23076916) + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat2 = u_xlat2 * vec4(_RenderViewportScaleFactor);
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat16_8.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat15 = u_xlat15 + -0.800000012;
    u_xlat15 = u_xlat15 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8;
    u_xlat15 = u_xlat15 * 0.31621623;
    u_xlat3 = u_xlat15 * u_xlat16_3.x;
    u_xlat16_8.x = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat3 = u_xlat16_8.x * 0.227027029 + u_xlat3;
    u_xlat16_4 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_8.xyz = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat8 = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat8 = u_xlat8 + -0.800000012;
    u_xlat8 = u_xlat8 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat13;
    u_xlat13 = u_xlat8 * 0.31621623;
    u_xlat15 = u_xlat8 * 0.31621623 + u_xlat15;
    u_xlat3 = u_xlat16_4.x * u_xlat13 + u_xlat3;
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat7 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat7 * -2.0 + 3.0;
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * 0.0702702701;
    u_xlat15 = u_xlat7 * 0.0702702701 + u_xlat15;
    u_xlat2.x = u_xlat16_2.x * u_xlat12 + u_xlat3;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat16_6.xyz);
    SV_Target0.yzw = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.x = u_xlat6 + -0.800000012;
    u_xlat0.x = u_xlat0.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat5 = u_xlat0.x * 0.0702702701;
    u_xlat0.x = u_xlat0.x * 0.0702702701 + u_xlat15;
    u_xlat0.x = u_xlat0.x + 0.227027029;
    u_xlat5 = u_xlat16_1.x * u_xlat5 + u_xlat2.x;
    SV_Target0.x = u_xlat5 / u_xlat0.x;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 270013
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.y / _AOParams.z;
    u_xlat0.y = float(1.38461542);
    u_xlat0.z = float(3.23076916);
    u_xlat1 = vec4(-0.0, -2.76923084, -0.0, -6.46153831) * u_xlat0.yxzx + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0 = vec4(0.0, 2.76923084, 0.0, 6.46153831) * u_xlat0.yxzx + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_8.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_7.x * 0.31621623;
    u_xlat16_2.x = u_xlat16_7.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_3.x * 0.227027029 + u_xlat16_2.x;
    u_xlat16_4 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_12 = dot(u_xlat16_8.xyz, u_xlat16_9.xyz);
    u_xlat16_12 = u_xlat16_12 + -0.800000012;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_12 * 0.31621623;
    u_xlat16_7.x = u_xlat16_12 * 0.31621623 + u_xlat16_7.x;
    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_2.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.x = dot(u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = u_xlat16_6.x + -0.800000012;
    u_xlat16_6.x = u_xlat16_6.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_11 = u_xlat16_6.x * 0.0702702701;
    u_xlat16_6.x = u_xlat16_6.x * 0.0702702701 + u_xlat16_7.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11 + u_xlat16_2.x;
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_8.xyz, u_xlat16_5.xyz);
    SV_Target0.yzw = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_5.x * 0.0702702701;
    u_xlat16_5.x = u_xlat16_5.x * 0.0702702701 + u_xlat16_6.x;
    u_xlat16_5.x = u_xlat16_5.x + 0.227027029;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_10 + u_xlat16_1.x;
    SV_Target0.x = u_xlat16_0.x / u_xlat16_5.x;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.y / _AOParams.z;
    u_xlat0.y = float(1.38461542);
    u_xlat0.z = float(3.23076916);
    u_xlat1 = vec4(-0.0, -2.76923084, -0.0, -6.46153831) * u_xlat0.yxzx + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0 = vec4(0.0, 2.76923084, 0.0, 6.46153831) * u_xlat0.yxzx + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_8.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_7.x * 0.31621623;
    u_xlat16_2.x = u_xlat16_7.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_3.x * 0.227027029 + u_xlat16_2.x;
    u_xlat16_4 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_12 = dot(u_xlat16_8.xyz, u_xlat16_9.xyz);
    u_xlat16_12 = u_xlat16_12 + -0.800000012;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_12 * 0.31621623;
    u_xlat16_7.x = u_xlat16_12 * 0.31621623 + u_xlat16_7.x;
    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_2.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.x = dot(u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = u_xlat16_6.x + -0.800000012;
    u_xlat16_6.x = u_xlat16_6.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_11 = u_xlat16_6.x * 0.0702702701;
    u_xlat16_6.x = u_xlat16_6.x * 0.0702702701 + u_xlat16_7.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11 + u_xlat16_2.x;
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_8.xyz, u_xlat16_5.xyz);
    SV_Target0.yzw = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_5.x * 0.0702702701;
    u_xlat16_5.x = u_xlat16_5.x * 0.0702702701 + u_xlat16_6.x;
    u_xlat16_5.x = u_xlat16_5.x + 0.227027029;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_10 + u_xlat16_1.x;
    SV_Target0.x = u_xlat16_0.x / u_xlat16_5.x;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _AOParams;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.y / _AOParams.z;
    u_xlat0.y = float(1.38461542);
    u_xlat0.z = float(3.23076916);
    u_xlat1 = vec4(-0.0, -2.76923084, -0.0, -6.46153831) * u_xlat0.yxzx + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0 = vec4(0.0, 2.76923084, 0.0, 6.46153831) * u_xlat0.yxzx + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * vec4(_RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * vec4(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_8.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_7.x * 0.31621623;
    u_xlat16_2.x = u_xlat16_7.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_3.x * 0.227027029 + u_xlat16_2.x;
    u_xlat16_4 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_12 = dot(u_xlat16_8.xyz, u_xlat16_9.xyz);
    u_xlat16_12 = u_xlat16_12 + -0.800000012;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_12 * 0.31621623;
    u_xlat16_7.x = u_xlat16_12 * 0.31621623 + u_xlat16_7.x;
    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_2.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.x = dot(u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = u_xlat16_6.x + -0.800000012;
    u_xlat16_6.x = u_xlat16_6.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_11 = u_xlat16_6.x * 0.0702702701;
    u_xlat16_6.x = u_xlat16_6.x * 0.0702702701 + u_xlat16_7.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11 + u_xlat16_2.x;
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_8.xyz, u_xlat16_5.xyz);
    SV_Target0.yzw = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_5.x * 0.0702702701;
    u_xlat16_5.x = u_xlat16_5.x * 0.0702702701 + u_xlat16_6.x;
    u_xlat16_5.x = u_xlat16_5.x + 0.227027029;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_10 + u_xlat16_1.x;
    SV_Target0.x = u_xlat16_0.x / u_xlat16_5.x;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 350403
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform 	vec3 _AOColor;
uniform 	vec4 _SAOcclusionTexture_TexelSize;
uniform mediump sampler2D _SAOcclusionTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0 = texture(_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xy = _SAOcclusionTexture_TexelSize.xy / _AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_7.x + u_xlat16_0.x;
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
    u_xlat16_4 = texture(_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = texture(_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + -0.800000012;
    u_xlat16_2.x = u_xlat16_2.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_2.x + u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_7.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_15 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.xyz = u_xlat16_0.xxx * _AOColor.xyz;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform 	vec3 _AOColor;
uniform 	vec4 _SAOcclusionTexture_TexelSize;
uniform mediump sampler2D _SAOcclusionTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0 = texture(_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xy = _SAOcclusionTexture_TexelSize.xy / _AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_7.x + u_xlat16_0.x;
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
    u_xlat16_4 = texture(_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = texture(_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + -0.800000012;
    u_xlat16_2.x = u_xlat16_2.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_2.x + u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_7.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_15 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.xyz = u_xlat16_0.xxx * _AOColor.xyz;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform 	vec3 _AOColor;
uniform 	vec4 _SAOcclusionTexture_TexelSize;
uniform mediump sampler2D _SAOcclusionTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0 = texture(_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xy = _SAOcclusionTexture_TexelSize.xy / _AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_7.x + u_xlat16_0.x;
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
    u_xlat16_4 = texture(_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = texture(_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + -0.800000012;
    u_xlat16_2.x = u_xlat16_2.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_2.x + u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_7.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_15 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.xyz = u_xlat16_0.xxx * _AOColor.xyz;
    SV_Target0.w = u_xlat16_0.x;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 425657
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
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform 	vec3 _AOColor;
uniform mediump sampler2D _SAOcclusionTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0 = texture(_SAOcclusionTexture, u_xlat0.xy);
    u_xlat1.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat1.xy = u_xlat1.xy / _AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_7.x + u_xlat16_0.x;
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
    u_xlat16_4 = texture(_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = texture(_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + -0.800000012;
    u_xlat16_2.x = u_xlat16_2.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_2.x + u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_7.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_15 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    SV_Target0.w = u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target1.xyz = u_xlat16_0.xxx * _AOColor.xyz;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target1.w = 0.0;
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
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform 	vec3 _AOColor;
uniform mediump sampler2D _SAOcclusionTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0 = texture(_SAOcclusionTexture, u_xlat0.xy);
    u_xlat1.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat1.xy = u_xlat1.xy / _AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_7.x + u_xlat16_0.x;
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
    u_xlat16_4 = texture(_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = texture(_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + -0.800000012;
    u_xlat16_2.x = u_xlat16_2.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_2.x + u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_7.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_15 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    SV_Target0.w = u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target1.xyz = u_xlat16_0.xxx * _AOColor.xyz;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target1.w = 0.0;
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
uniform 	vec4 _ScreenParams;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform 	vec3 _AOColor;
uniform mediump sampler2D _SAOcclusionTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0 = texture(_SAOcclusionTexture, u_xlat0.xy);
    u_xlat1.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat1.xy = u_xlat1.xy / _AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_7.x + u_xlat16_0.x;
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
    u_xlat16_4 = texture(_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = texture(_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + -0.800000012;
    u_xlat16_2.x = u_xlat16_2.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_2.x + u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_7.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_15 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    SV_Target0.w = u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target1.xyz = u_xlat16_0.xxx * _AOColor.xyz;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target1.w = 0.0;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 476086
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform 	vec4 _SAOcclusionTexture_TexelSize;
uniform mediump sampler2D _SAOcclusionTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0 = texture(_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xy = _SAOcclusionTexture_TexelSize.xy / _AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_12 * u_xlat16_7.x + 1.0;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
    u_xlat16_4 = texture(_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = texture(_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + -0.800000012;
    u_xlat16_2.x = u_xlat16_2.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_2.x + u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_7.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_15 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.xyz = (-u_xlat16_0.xxx) + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform 	vec4 _SAOcclusionTexture_TexelSize;
uniform mediump sampler2D _SAOcclusionTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0 = texture(_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xy = _SAOcclusionTexture_TexelSize.xy / _AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_12 * u_xlat16_7.x + 1.0;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
    u_xlat16_4 = texture(_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = texture(_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + -0.800000012;
    u_xlat16_2.x = u_xlat16_2.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_2.x + u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_7.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_15 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.xyz = (-u_xlat16_0.xxx) + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
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
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _AOParams;
uniform 	vec4 _SAOcclusionTexture_TexelSize;
uniform mediump sampler2D _SAOcclusionTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_0 = texture(_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = u_xlat16_0.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xy = _SAOcclusionTexture_TexelSize.xy / _AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat2.xy = u_xlat2.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_2 = texture(_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = u_xlat16_2.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_12 * u_xlat16_7.x + 1.0;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + vs_TEXCOORD0.xyxy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1 = texture(_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * vec4(_RenderViewportScaleFactor);
    u_xlat16_4 = texture(_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = texture(_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = u_xlat16_4.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + -0.800000012;
    u_xlat16_2.x = u_xlat16_2.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_2.x + u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_4.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_7.xyz = u_xlat16_3.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + -0.800000012;
    u_xlat16_7.x = u_xlat16_7.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_0.x;
    u_xlat16_6.xyz = u_xlat16_1.yzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + -0.800000012;
    u_xlat16_5.x = u_xlat16_5.x * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_15 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.xyz = (-u_xlat16_0.xxx) + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
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