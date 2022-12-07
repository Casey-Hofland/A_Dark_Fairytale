#nullable enable
using System.Collections;
using UnityEngine;
using UnityEngine.Rendering.Universal;

[RequireComponent(typeof(Camera))]
public class VolumeUpdater : MonoBehaviour
{
    [SerializeField] private float _updateFrequency = 1 / 60f;
    public float updateFrequency 
    {
        get => _updateFrequency;
        set => _updateInstruction = new(_updateFrequency = value);
    }

    private Camera? _camera;
    private WaitForSeconds? _updateInstruction;
    private Coroutine? _updateVolumeStackRoutine;

    public Camera GetCamera() => GetComponent<Camera>();

    private void Awake()
    {
        _camera = GetCamera();
        _updateInstruction = new(updateFrequency);
    }

    private void OnEnable()
    {
        _updateVolumeStackRoutine = StartCoroutine(UpdateVolumeStackRoutine());
    }

    private void OnDisable()
    {
        StopCoroutine(_updateVolumeStackRoutine);
    }

    IEnumerator UpdateVolumeStackRoutine()
    {
        _camera?.UpdateVolumeStack();
        yield return _updateInstruction;

        yield return UpdateVolumeStackRoutine();
    }
}
